class BooksController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_both, only: [:show, :update, :destroy]
#  def index
#    @books = Book.all
#
#    render json: @books
#  end

  def show
    render json: @books
  end

  def set_both
    @user = User.find(params[:id])
    @book = @user.books.find_by_title(params[:title])
  end
end
