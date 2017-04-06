class BooksController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_both, only: [:show, :update, :destroy]
  before_action :set_book, only: [:update, :destroy]

  def index
    @books = Book.all

    render json: @books
  end

  def show
    #@book = Book.find(params [:title])

    render json: @book
  end

  def set_both
    @user = User.find(params[:id])

    @book = @user.books.find(params[:id_book])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def book_params
    params.require(:book).permit(:title, :idNumber)
  end

  def update
    @book.update(:id)
  end

  def destroy
    @book.destroy
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def set_both
      @user = User.find(params[:id])
      @book = @user.books.find(params[:id_book])
    end
end
