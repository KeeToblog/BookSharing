class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    # @user = User.find(params[:user_id])
    # @book = @user.books.find(params[:id])
  end

  def help
  end

  def about
  end

  def contact
  end
end
