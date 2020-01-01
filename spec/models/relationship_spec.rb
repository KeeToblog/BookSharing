require 'rails_helper'

RSpec.describe Relationship, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
    @relationship = Relationship.new(follower_id: @user.id, followed_id: @other_user.id)
  end

  # 有効性のテスト
  describe "validation" do
    # @relationshipが有効かどうか
    it "has a valid factory" do
      expect(@relationship).to be_valid
    end
  end

  # 存在性のテスト
  describe "presence" do
    # follower_idが必要かどうか
    it "requires a follower_id" do
      @relationship.follower_id = nil
      expect(@relationship).not_to be_valid
    end
    # followed_idが必要かどうか
    it "requires a followed_id" do
      @relationship.followed_id = nil
      expect(@relationship).not_to be_valid
    end
  end

  # ユーザー同士のフォロー関係のテスト
  describe "" do
    it "an user follows other user" do
      expect(@user.following?(@other_user)).not_to be true
      @user.follow(@other_user)
      expect(@user.following?(@other_user)).to be true
      expect(@other_user.followers.include?(@user)).to be true
      @user.unfollow(@other_user)
      expect(@user.following?(@other_user)).not_to be true
    end
  end

end
