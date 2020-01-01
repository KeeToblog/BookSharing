require 'rails_helper'

RSpec.feature "UsersAdmin", type: :feature do

  include LoginSupport

  # admin属性のテスト
  feature "admin attribute", type: :request  do

    background do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:other_user)
      @admin_user = FactoryBot.create(:admin_user)
    end

    # 管理者でないユーザーのアクション
    context "an user without admin attribute" do
      # Web経由で管理権限を変更する
      scenario "edit the attribute via web" do
        login_as(@user)
        expect(@user.admin).to eq false
        patch user_path(@user), params: { user: { password:  "foobar",
                                                        password_confirmation: "foobar",
                                                        admin: true } }
        expect(@user.admin).not_to eq true
      end
      # ユーザー削除のリクエストを直接送る
      scenario "destroy users" do
        expect{
          delete user_path(@other_user)
        }.to change(User, :count).by(0)
        expect(response).to redirect_to(login_url)
      end
      # ログインした後にユーザーを削除する
      scenario "after logged in, destroy users" do
        login_as(@user)
        expect{
          delete user_path(@other_user)
        }.to change(User, :count).by(0)
        expect(response).to redirect_to(root_url)
      end
    end
    # 管理ユーザーのアクション
    context "an user with admin attirbute" do
      # ログインした後にユーザーを削除する
      scenario "after logged in, destroy users" do
        visit login_path
        fill_in_login_form(@admin_user, invalid: false)
        click_button "ログイン"
        login_as(@admin_user)
        visit users_path
        User.paginate(page: 1).each do |user|
          expect(page).to have_css("li", text: user.name)
          expect(page).to have_content("削除")
        end
        expect{
          delete user_path(@other_user)
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to(users_url)
      end
    end
  end
end
