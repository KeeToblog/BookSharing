require 'rails_helper'

RSpec.feature "UsersEdit", type: :feature do
  
  include LoginSupport
  include EditSupport

  # プロフィール編集ページ(/users/:id/edit)のテスト
  feature "profile edit page", type: :request do

    background do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:other_user)
      @deactivated_user = FactoryBot.create(:deactivated_user)
    end

    # 認可されたユーザーのアクション
    context "an authorized user" do
      # @userとしてログインし、プロフィール編集ページ(/users/:id/edit)へアクセスする
      background do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        visit edit_user_path(@user)
        expect(current_path).to eq edit_user_path(@user)
      end
      # 他のユーザーのプロフィール編集ページへアクセスする
      scenario "accesses an edit page of other user" do
        visit edit_user_path(@other_user)
        expect(current_path).to eq root_path
      end
      # ユーザー情報を編集する
      context "edit profile" do
        # 無効なユーザー情報
        scenario "with invalid user information" do
          fill_in_edit_form(@user, invalid: true)
          click_button "プロフィールを編集"
          expect(page).to have_content('The form contains 4 errors.')
          expect(page).to have_css('div.alert.alert-danger')
        end
        # 有効なユーザー情報
        scenario "with valid user information" do
          fill_in_edit_form(@user, invalid: false)
          click_button "プロフィールを編集"
          expect(@user.reload.name).not_to eq ""
          expect(@user.reload.email).not_to eq "user@invalid"
          expect(page).to have_content('プロフィールを更新しました')
        end
        # 他のユーザーのプロフィール情報を編集する（PATCHリクエストを直接送る）
        scenario "update profile of other user" do
          patch user_path(@other_user), params: { user: { name: @other_user.name, email: @other_user.email } }
          expect(response).to redirect_to(login_path)
        end
      end
    end
    # 非認可ユーザーのアクション
    context "an unauthorized user" do
      # プロフィール編集ページにアクセスする
      scenario "accesses an edit page" do
        visit edit_user_path(@user)
        expect(current_path).to eq login_path
        expect(page).to have_css('div.alert.alert-danger')
        expect(page).to have_content('ログインしてください')
      end
      # プロフィールを編集する(PATCHリクエストを直接送る)
      scenario "update profile" do
        patch user_path(@user), params: { user: {name: @user.name, email: @user.email } }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
