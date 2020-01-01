require 'rails_helper'

RSpec.feature "UsersSignup", type: :feature do

  include HeaderSupport
  include SignupSupport
  include LoginSupport

  # def setup
  #   ActionMailer::Base.deliveries.clear
  # end

  # トップページから新規登録ページへ移動する。（ユーザーの有効化状態をfalseにしておく。）
  background do
    @user = FactoryBot.create(:user, activated: false)
    visit root_path
    click_link "新規登録"
    visit signup_path
  end

  # 新規登録のテスト
  feature "signup", type: :request  do
    # 無効なユーザー情報で新規登録する
    scenario "with invalid information" do
      fill_in_signup_form(@user, invalid: true)
      expect {
        click_button "新規登録"
      }.to change(User, :count).by(0)
      expect(page).to have_css('div.alert.alert-danger', text: "error")
      header_has_right_link(@user, login: false)
    end
    # 有効なユーザー情報で新規登録したのち、ログインする
    feature "with valid information followed by login" do
      # 有効化トークンつきの確認メールが送信される
      background do
        fill_in_signup_form(@user, invalid: false)
        expect {
          click_button "新規登録"
        }.to change(User, :count).by(1)
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(@user.activated).not_to eq true
      end
      # 有効化していない
      scenario "without activation" do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        header_has_right_link(@user, login: false)
      end
      # 有効化トークンが不正
      scenario "with invalid token" do
        get edit_account_activation_path("invalid token", email: @user.email)
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        header_has_right_link(@user, login: false)
      end
      # 間違ったメールアドレス
      scenario "with wrong email address" do
        get edit_account_activation_path(@user.activation_token, email: "wrong email address")
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        header_has_right_link(@user, login: false)
      end
      # メールアドレスと有効化トークンのペアが一致している
      scenario "with correct email address and activation token" do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        header_has_right_link(@user, login: true)
        expect(@user.activated).to eq false
        expect(@user.reload.activated).to eq true
        expect(response).to redirect_to(@user)
      end
    end
  end
end
