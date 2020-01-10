require 'rails_helper'

RSpec.describe Book, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book, user: @user)
  end

  # @bookが有効かどうかテスト
  describe "validation" do
    it "has a valid factory" do
      expect(@book).to be_valid
    end
  end

  # 存在性のテスト
  describe "presence" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_presence_of :author}
    it {is_expected.to validate_presence_of :content}
    it {is_expected.to validate_presence_of :good_point}
  end

  # 長さのテスト
  describe "length" do
    it {is_expected.to validate_length_of(:title).is_at_most(100)}
    it {is_expected.to validate_length_of(:author).is_at_most(50)}
    it {is_expected.to validate_length_of(:content).is_at_most(500)}
    it {is_expected.to validate_length_of(:good_point).is_at_most(500)}
  end
  
  # 投稿順序のテスト
  describe "create date" do
    #最新のものが一番上にくる
    it "is placed in descending order" do
      book1 = FactoryBot.create(:book, :newest, user: @user)
      book2 = FactoryBot.create(:book, :oldest, user: @user)
      book3 = FactoryBot.create(:book, :second_oldest, user: @user)
      book4 = FactoryBot.create(:book, :second_newest, user: @user)
      expect(book1).to eq Book.find(1)
      expect(@book).to eq Book.find(2)
      expect(book4).to eq Book.find(3)
      expect(book3).to eq Book.find(4)
      expect(book2).to eq Book.find(5)
    end
  end

  # ユーザーと本との関連付け
  describe "book associated with user" do
    it "is also destoryed as user destoryed" do
      expect {
        @user.destroy
      }.to change(Book, :count).by(-1)
    end
  end



end
