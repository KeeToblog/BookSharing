require 'rails_helper'

RSpec.describe User do

  # 存在性のテスト
  it {is_expected.to validate_presence_of :name}
  it {is_expected.to validate_presence_of :email}
  it {is_expected.to validate_presence_of :password}

  # has_secure_passwordメソッドのテスト
  it {is_expected.to have_secure_password}

  # 長さのテスト
  it {is_expected.to validate_length_of(:name).is_at_most(50)}
  it {is_expected.to validate_length_of(:email).is_at_most(255)}
  it {is_expected.to validate_length_of(:password).is_at_least(6)}

  before do
    @user = FactoryBot.create(:user)
    # buildメソッドはユーザーをインスタンス化して新しいユーザーを作るが、保存はしない(メモリ内に保存する)。createメソッドはテスト用DBにオブジェクトを永続化する。
  end

  # @userが有効かどうかテスト
  it "has a valid factory" do
    expect(@user).to be_valid
  end

  # 存在性のテスト
  describe "presence" do
    it "is invalid without a name" do
      @user.name = nil
      expect(@user).not_to be_valid
      expect(@user.errors[:name]).to include("can't be blank")
    end
    it "is invalid without a email" do
      @user.email = nil
      expect(@user).not_to be_valid
      expect(@user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      @user.password = @user.password_confirmation = nil
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end
  end

  # 長さのテスト
  describe "length" do
    it "is invalid with a long name" do
      @user.name = "a" * 51
      expect(@user).not_to be_valid
      expect(@user.errors[:name]).to include("is too long (maximum is 50 characters)")
    end
    it "is invalid with a long email" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user).not_to be_valid
      expect(@user.errors[:email]).to include("is too long (maximum is 255 characters)")
    end
    it "is invalid with a short password and password_confirmation" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  #メールフォーマットのテスト
  describe "email format" do
    # 有効なメルアドのとき
    context "when valid format" do
      it "is valid with valid email addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.lat@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          @user.valid? "#{valid_address.inspect} should be valid"
        end
      end
    end
    # 無効なメルアド
    context "when invalid format" do
      it "is invalid with invalid email addresses" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end
  end

  # メルアドの一意性のテスト
  describe "email uniqueness" do
    # メルアドの重複
    context "when a duplicate email address" do
      it "is invalid with a duplicate email address" do
        user = FactoryBot.create(:user, email: "duplicate@example.com")
        dup_user = FactoryBot.build(:user, email: "duplicate@example.com")
        dup_user.email = user.email.upcase
        user.save
        expect(dup_user).not_to be_valid
        expect(dup_user.errors[:email]).to include("has already been taken")
      end
    end
    # メルアドの小文字化（DBアダプタが常に大文字小文字を区別するインデックスを使っているとは限らない）
    context "when an email address is saved as lower-case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
      it "is valid with a lower-case email address" do
        @user.email = mixed_case_email
        @user.save
        expect(@user.reload.email).to eq mixed_case_email.downcase
      end
    end
  end

  # 以下のテストは機能していない

  # # ステータスフィードのテスト
  # describe "status feed of an user" do
  #   # 正しい投稿内容を表示していること
  #   context "displays the right posts" do
  #     it "with its following user" do
  #       michael = FactoryBot.create(:other_user, name: 'michael')
  #       archer = FactoryBot.create(:other_user, name: 'archer')
  #       lana = FactoryBot.create(:other_user, name: 'lana')
  #       michael.follow(lana)
  #       lana.follow(michael)
  #       archer.follow(michael)
  #       # フォローしているユーザーの投稿を確認
  #       lana.microposts.each do |post_following|
  #         expect(lana.feed).to include(post_following)
  #       end
  #       # 自分自身の投稿を確認
  #       michael.microposts.each do |post_self|
  #         expect(michael.feed).to include(post_self)
  #       end
  #       # フォローしていないユーザーの投稿を確認
  #       archer.microposts.each do |post_unfollowed|
  #         expect(archer.feed).not_to include(post_unfollowed)
  #       end
  #     end
  #   end
  # end
end
