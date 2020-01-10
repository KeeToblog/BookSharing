require 'rails_helper'

RSpec.feature "BooksShelf", type: :feature do

  include LoginSupport

  # 本棚ページ(/users/:id/books)のテスト
  feature "books shelf", type: :request do

    background do
      @user = FactoryBot.create(:user)
      @book = FactoryBot.create(:book, user: @user)
    end

    # 認可されたユーザーのアクション
    context "an authorized user" do
      # @userとしてログインし、本棚ページ(/users/:id/books)へアクセスする
      background do
        visit login_path
        fill_in_login_form(@user, invalid: false)
        click_button "ログイン"
        expect(current_path).to eq user_path(@user)
        click_link "本棚を編集"
        expect(current_path).to eq books_path(@user)
      end
      # 正しい本棚の要素が表示されていること
      scenario "accesses bookshelf page with correct elements" do
        Book.paginate(page: 1).each do |book|
          expect(page).to have_css("h5.card-title", text: @book.title)
          expect(page).to have_css("p.card-text", text: "#{@book.content}")
        end
      end
    end
    # 非認可ユーザーのアクション
    context "an unauthorized user" do
      # 本棚ページ(/users/:id/books)へアクセスする
      scenario "accesses bookshelf page" do
        get books_path(@user)
        expect(response).to redirect_to login_path
      end
      # 本を作成する(POSTリクエストを直接送る)
      scenario "creates book" do
        post books_path(@user), params: { book: { title: "BAAAAN" } }
        expect(response).to redirect_to login_path
      end
      # 本を削除する(DELETEリクエストを直接送る)
      scenario "destroy book" do
        delete book_path(@book)
        expect(response).to redirect_to login_path
      end
    end
  end
end
