require 'rails_helper'
# require './spec/support/login_support.rb'

RSpec.feature "UsersLogin", type: :feature do

  include HeaderSupport
  include LoginSupport

  # トップページからログインページへ移動する
  background do
    @user = FactoryBot.create(:user)
    visit root_path
    click_link 'ログイン'
    visit login_path
  end

  # ログインのテスト
  feature "login", type: :request do
    # 無効なユーザー情報
    scenario "with invalid information" do
      fill_in_login_form(@user, invalid: true)
      click_button "ログイン"
      login_as(@user)
      header_has_right_link(@user, login: false)
      # フラッシュメッセージの確認
      expect(page).to have_css('div.alert.alert-danger')
      visit root_path
      expect(page).not_to have_css('div.alert.alert-danger')
    end
    # 有効なユーザー情報
    scenario "with valid information" do
      fill_in_login_form(@user, invalid: false)
      click_button "ログイン"
      login_as(@user)
      header_has_right_link(@user, login: true)
      # ログアウトする
      click_link "ログアウト"
      delete logout_path(@user)
      expect(response).to redirect_to('/')
      expect(session[:user_id]).to eq nil
      header_has_right_link(@user, login: false)
      # ２回目のログアウト
      delete logout_path(@user)
      expect(response).to redirect_to('/')
    end
    # 「ログインしたままにする(remember_me)」をチェックしてログインする
    scenario "with remembering" do
      fill_in_login_form(@user, invalid: false)
      click_button "ログイン"
      login_as(@user, remember_me: '1')
      header_has_right_link(@user, login: true)
      expect(response.cookies['remember_token']).not_to eq nil
      delete logout_path
    end
    # 「ログインしたままにする(remember_me)」をチェックしないでログインする
    scenario "without remembering" do
      fill_in_login_form(@user, invalid: false)
      click_button "ログイン"
      login_as(@user, remember_me: '0')
      header_has_right_link(@user, login: true)
      expect(response.cookies['remember_token']).to eq nil
    end
    # フレンドリーフォワーディングのテスト
    context "friendly forwarding" do
      # ログインした後は任意のページにリダイレクトしてあげる
      scenario "render desired page" do
        get edit_user_path(@user)
        expect(response).to redirect_to(login_path)
        post login_path, params: { session: { email: @user.email, password: @user.password} }
        expect(response).to redirect_to(edit_user_path(@user))
        expect(session[:forwarding_url]).to eq nil
        # ログアウトする
        delete logout_path(@user)
        expect(response).to redirect_to('/')
        # 再度ログインするとデフォルトのページ(/users/:id)にリダイレクトする
        login_as(@user)
      end
    end
  end
end
