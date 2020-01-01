require 'rails_helper'

RSpec.feature "UsersProfile", type: :feature do

  include LoginSupport

  # プロフィールページ(/users/:id)のテスト
  feature "user profile", type: :request do

    background do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:other_user)
      @deactivated_user = FactoryBot.create(:deactivated_user)
      @micropost = FactoryBot.create(:micropost, user: @user)
      @other_micropost = FactoryBot.create(:micropost, user: @other_user)
    end
    
    # 認可されたユーザーのアクション
    context "an authorized user" do
      # @userとしてログインし、プロフィールページ(/users/:id)へアクセスする
      background do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        visit user_path(@user)
        expect(current_path).to eq user_path(@user)
      end
      # 正しいマイクロポスト要素が表示されていること
      scenario "accsesses a profile page with correct micropost elements" do
        expect(page).to have_css("h3", text: @user.name)
        expect(page).to have_css("h5", text: "Microposts (#{@user.microposts.count})")
        expect(page).to have_css("a", text: "#{@user.following.count} フォロー")
        expect(page).to have_css("a", text: "#{@user.followers.count} フォロワー")
        Micropost.paginate(page: 1).each do |micropost|
          expect(page).to have_css("li", text: @user.name)
          expect(page).to have_css("span.timestamp", text: "| Posted")
          expect(page).to have_css("p.span.content", text: "#{@micropost.content}")
          expect(page).to have_link("削除")
        end
      end
      # 違うユーザーのページにアクセスし、削除リンクが表示されていない
      scenario "accesses a profile page of other user without delete path" do
        visit user_path(@other_user)
        expect(page).to have_css("h3", text: @other_user.name)
        expect(page).to have_css("h5", text: "Microposts (#{@other_user.microposts.count})")
        Micropost.paginate(page: 1).each do |micropost|
          expect(page).to have_css("li", text: @other_user.name)
          expect(page).to have_css("span.timestamp", text: "| Posted")
          expect(page).to have_css("p.span.content", text: "#{@other_micropost.content}")
          expect(page).not_to have_link("削除")
        end
      end
    end
    # 非認可ユーザーのアクション
    context "an unauthorized user" do
      # プロフィールページ(/users/:id)へアクセスする
      scenario "accesses a profile page" do
        visit user_path(@deactivated_user)
        expect(current_path).to eq root_path
      end
      # # フォローする(POSTリクエストを直接送る)
      # scenario "follow an user" do
      #   post relationships_path
      #   expect(current_path).to eq login_path
      # end
      # # フォローを外す(DELETEリクエストを直接送る)
      # scenario "unfollow an user" do
      #   delete relationship_path(relationships(@user))
      #   expect(current_path).to eq login_path
      # end
    end
  end
end
