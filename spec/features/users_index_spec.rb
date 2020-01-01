require 'rails_helper'

RSpec.feature "UsersIndex", type: :feature do

  include LoginSupport

  # ユーザー一覧ページ(/users)のテスト
  feature "user index page", type: :request do

    background do
      @user = FactoryBot.create(:user)
      @deactivated_user = FactoryBot.create(:deactivated_user)
    end

    # 認可されたユーザーのアクション
    context "an authorized user" do
      # @userとしてログインし、ユーザー一覧ページ(/users)へアクセスする
      background do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        login_as(@user)
        visit users_path
        expect(current_path).to eq users_path
      end
      # 正しいユーザー情報が表示されていること
      scenario "accesses index pages with correct users information" do
        expect(page).to have_css("h1", text: "ユーザー一覧")
        # expect(page).to have_css("pagination")
        User.paginate(page: 1).each do |user|
          expect(page).not_to have_css("li", text: @deactivated_user.name)
          expect(page).to have_css("li", text: @user.name)
          expect(page).not_to have_link(users_path(@deactivated_user))
        end
      end
    end
    # 非認可ユーザーのアクション
    context "an unauthorized user" do
      # ユーザー一覧ページ(/users)へアクセスする
      scenario "accesses index pages" do
        get users_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
