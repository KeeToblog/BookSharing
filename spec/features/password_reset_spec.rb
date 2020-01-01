require 'rails_helper'

RSpec.feature "PasswordReset", type: :feature do

  include PasswordResetSupport

  # def setup
  #   ActionMailer::Base.deliveries.clear
  # end

  # background do
  #   @user = FactoryBot.create(:user)
  #   # なぜか改めてreset_tokenを定義しないと[:id]がnilになる
  #   # @user.reset_token = User.new_token
  # end

  # パスワード再設定のテスト
  feature "password resets", type: :request do

    # リセットトークンつきメールの送信
    context "send an email with reset-token" do
      # 「ログインパスワードの再設定手続き(/password_resets/new)」へ移動する
      background do
        @user = FactoryBot.create(:user)
        visit login_path
        click_link "パスワードがわからない方はこちら"
        expect(page).to have_content("ログインパスワードの再設定手続き")
      end
      # 無効なメールアドレス
      scenario "to invalid email address" do
        fill_in_signed_up_email_form(@user, invalid: true)
        click_button "パスワード再設定用メールを送信"
        expect(page).to have_css("div.alert.alert-danger")
        expect(page).to have_content("メールアドレスが見つかりません")
      end
      # 有効なメールアドレス
      scenario "to valid email address" do
        # post password_resets_path, params: { password_reset: { email: @user.email } }
        # expect(response).to redirect_to(root_url)
        fill_in_signed_up_email_form(@user, invalid: false)
        click_button "パスワード再設定用メールを送信"
        expect(current_url).to eq root_url
        expect(page).to have_content("パスワード再設定用のメールを送信しました。")
        expect(@user.reset_digest).not_to eq @user.reload.reset_digest
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end

    # 以下のテストはassignsメソッド、reset_tokenが機能しないため停止

    # # パスワード再設定フォームのテスト
    # context "password reset form" do
    #   background do
    #     @user = FactoryBot.create(:user)
    #     # @user.reset_token = User.new_token
    #     visit new_password_reset_path
    #     fill_in_signed_up_email_form(@user, invalid: false)
    #     click_button "パスワード再設定用メールを送信"
    #     expect(ActionMailer::Base.deliveries.size).to eq 1
    #   end
    #   # 「パスワード再設定ページ(/password_resets/:id/edit)」へアクセスする
    #   # 無効なユーザー
    #   scenario "is accessed by invalid user" do
    #     user = assigns(:user)
    #     user.toggle!(:activated)
    #     visit edit_password_reset_path(user.reset_token, email: user.email)
    #     expect(current_url).to eq root_url
    #   end
    #   # メールアドレスが有効でリセットトークンが無効
    #   scenario "is accessed with invalid reset token" do
    #     user = assigns(:user)
    #     get edit_password_reset_path("wrong token", email: user.email)
    #     expect(current_url).to eq root_url
    #   end
    #   # リセットトークンが有効でメールアドレスが無効
    #   scenario "is accessed with invalid email address" do
    #     user = assigns(:user)
    #     get edit_password_reset_path(user.reset_token, email: "")
    #     expect(current_url).to eq root_url
    #   end
    #   #メールアドレスもトークンも有効
    #   scenario "is accessed with valid email address and reset token" do
    #     user = assigns(:user)
    #     get edit_password_reset_path(user.reset_token, email: user.email)
    #     expect(current_url).to eq user_path(user)
    #     fill_in "パスワード", with: "foobaz"
    #     fill_in "パスワード（確認）", with: "foobaz"
    #     expect(current_url).to eq @user
    #   end
    # end

    # # パスワード再設定の有効期限のテスト
    # context "expired test" do
    #   scenario "expired test" do
    #     @user = FactoryBot.create(:user)
    #     visit new_password_reset_path
    #     fill_in_signed_up_email_form(@user, invalid: false)
    #     click_button "パスワード再設定用メールを送信"
    #     expect(current_url).to eq root_url
    #     user = assigns(:user)
    #     user.update_attribute(:reset_sent_at, 3.hours.ago)
    #     get edit_password_reset_path(user.reset_token, email: user.email)
    #     patch password_reset_path(user.reset_token), params: { email: user.email,
    #                                                             user: { password: "foobaz",
    #                                                                     password_confirmation: "foobaz" } }
    #     expect(response).to redirect_to(user)
    #     fill_in "パスワード", with: "foobaz"
    #     fill_in "パスワード（確認）", with: "foobaz"
    #   end
    # end

  end
end
