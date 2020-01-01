require 'rails_helper'

RSpec.feature "Followings", type: :feature do

  include LoginSupport

  # following/followerページのテスト
  feature "Follow and Following" , type: :request do
    
    background do
      @user = FactoryBot.create(:user)
      @users = FactoryBot.create_list(:other_user, 50)
      @users.each do |u|
        @user.follow(u)
        u.follow(@user)
      end
    end

    # 認可されたユーザーのアクション
    context "an authorized user" do
      # @userとしてログインする。
      background do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        expect(current_path).to eq user_path(@user)
      end
      # フォローページ(users/:id/following)へアクセスする
      scenario "accesses the follow page" do
        visit following_user_path(@user)
        expect(@user.following.count).to eq 50
        expect(page).to have_css('img.gravatar')
        expect(page).to have_css("h3", text: @user.name)
        expect(page).to have_link("ユーザー情報", href: user_path(@user))
        expect(page).to have_content("Microposts:#{@user.microposts.count}")
        expect(page).to have_link("フォロー", href: following_user_path(@user))
        @user.following.paginate(page: 1).each do |u|
          expect(page).to have_css("li", text: u.name)
          expect(page).to have_link(u.name, href: user_path(u))
        end
      end
      # フォロワーページ(users/:id/followers)へアクセスする
      scenario "accesses the follower page" do
        visit followers_user_path(@user)
        expect(@user.followers.count).to eq 50
        expect(page).to have_css('img.gravatar')
        expect(page).to have_css("h3", text: @user.name)
        expect(page).to have_link("ユーザー情報", href: user_path(@user))
        expect(page).to have_content("Microposts:#{@user.microposts.count}")
        expect(page).to have_link("フォロワー", href: followers_user_path(@user))
        @user.following.paginate(page: 1).each do |u|
          expect(page).to have_css("li", text: u.name)
          expect(page).to have_link(u.name, href: user_path(u))
        end
      end
      # フォロー/フォロー解除ボタンのテスト
      context "follow/unfollow button" do
        # フォローする
        scenario "follow a user with Ajax" do
          other_user = FactoryBot.create(:other_user)
          visit user_path(other_user)
          expect(@user.following.count).to eq 50
          click_button 'フォロー'
          expect(@user.following.count).to eq 51
        end
        # フォローを外す
        scenario "follow a user with Ajax" do
          visit user_path(@users)
          expect(@user.following.count).to eq 50
          click_button 'フォロー中'
          expect(@user.following.count).to eq 49
        end
      end
    end
    # 非認可ユーザーのアクション
    context "an unauthorized user" do
      # フォローページ(/users/:id/follwing)へアクセスする
      scenario "accesses a follwing page" do
        visit following_user_path(@user)
        expect(current_path).to eq login_path
      end
      # フォロワーページ(/users/:id/followers)へアクセスする
      scenario "accesses a followers page" do
        visit followers_user_path(@user)
        expect(current_path).to eq login_path
      end
    end
  end
end
