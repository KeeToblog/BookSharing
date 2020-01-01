require 'rails_helper'

RSpec.feature "Microposts", type: :feature do

  include LoginSupport
  include MicropostSupport

  # マイクロポストのテスト
  feature "Microposts", type: :request do

    background do
      @user = FactoryBot.create(:user)
      @micropost = FactoryBot.create(:micropost, user: @user)
    end

    # 認可されたユーザーのアクション
    context "an authorized user" do
      # @userとしてログインし、ホームページへアクセスする
      background do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        expect(current_path).to eq user_path(@user)
        visit root_path
      end
      # 正しいマイクロポスト要素が表示されていること
      scenario "accesses home page with correct micropost elements" do
        Micropost.paginate(page: 1).each do |micropost|
          expect(page).to have_css("li", text: @user.name)
          expect(page).to have_css("span.timestamp", text: "| Posted")
          expect(page).to have_css("p.span.content", text: "#{@micropost.content}")
          expect(page).to have_link("削除")
        end
      end
      # マイクロポストフォームのテスト
      context "on micropost form," do
        # 有効な内容を送信
        scenario "posts valid content" do
          fill_in_micropost_form(@user, invalid: false)
          expect {
            click_button "投稿する"
          }.to change(Micropost, :count).by(1)
          expect(page).to have_content('投稿されました！')
          expect(current_path).to eq root_path
        end
        # 無効な内容を送信
        scenario "posts invalid content" do
          fill_in_micropost_form(@user, invalid: true)
          expect {
            click_button "投稿する"
          }.to change(Micropost, :count).by(0)
          expect(page).to have_css('div.alert.alert-danger', text: "error")
        end
      end
      # マイクロポストを一つ削除する
      scenario "destroys a micropost form" do
        expect {
          click_link "削除"
        }.to change(Micropost, :count).by(-1)
        expect(page).to have_content('削除されました')
        expect(current_path).to eq root_path
      end
    end
    # 非認可ユーザーのアクション
    context "an unauthorized user" do
      # マイクロポストを作成する(POSTリクエストを直接送る)
      scenario "creates micropost" do
        post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
        expect(response).to redirect_to login_path
      end
      # マイクロポストを削除する(DELETEリクエストを直接送る)
      scenario "destroy micropost" do
        delete micropost_path(@micropost)
        expect(response).to redirect_to login_path
      end
    end
  end
end
