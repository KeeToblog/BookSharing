class BooksController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @books = @user.books.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:user_id])
    @book = @user.books.find(params[:id])
  end

  def new
    @book = current_user.books.build if logged_in?
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "登録されました！"
      redirect_to user_books_path(current_user)
    else
      flash[:danger] = "登録に失敗しました"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @book = @user.books.find(params[:id])
    unless @user == current_user
      redirect_to request.referrer || user_books_path(current_user)
      flash[:danger] = "他のユーザーの本棚は編集できません"
    end
  end

  def update
    # @user = User.find(params[:user_id])
    @book = current_user.books.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "本の内容が変更されました"
      redirect_to user_book_path(current_user, @book.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "本が削除されました"
    redirect_to request.referrer || root_url
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :content, :good_point, :picture)
    end
  
    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to(root_url) if @book.nil?
    end
end
