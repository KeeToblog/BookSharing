require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @micropost = FactoryBot.create(:micropost, user: @user)
  end

  # @micropostが有効かどうかテスト
  it "has a valid factory" do
    expect(@micropost).to be_valid
  end

  # 存在性のテスト
  describe "presence" do
    it "is invalid without user_id" do
      @micropost.user_id = nil
      expect(@micropost).not_to be_valid
      expect(@micropost.errors[:user_id]).to include("can't be blank")
    end
    it "is invalid without content" do
      @micropost.content = nil
      expect(@micropost).not_to be_valid
      expect(@micropost.errors[:content]).to include("can't be blank")
    end
  end

  # 長さのテスト
  describe "length" do
    it "is invalid with long content" do
      @micropost.content = "a" * 141
      expect(@micropost).not_to be_valid
      expect(@micropost.errors[:content]).to include("is too long (maximum is 140 characters)")
    end
  end

  # 投稿順序のテスト
  describe "create date" do
    #最新のものが一番上にくる
    it "is placed in descending order" do
      old_post = FactoryBot.create(:micropost, :orange, user: @user)
      newest_post = FactoryBot.create(:micropost, :most_recent, user: @user)
      expect(newest_post).to eq Micropost.first
      expect(@micropost).to eq Micropost.second
      expect(old_post).to eq Micropost.third
    end
  end

  # ユーザーとマイクロポストの関連付け
  describe "Micropost associated with user" do
    it "is also destoryed as user destoryed" do
      expect {
        @user.destroy
      }.to change(Micropost, :count).by(-1)
    end
  end

end
