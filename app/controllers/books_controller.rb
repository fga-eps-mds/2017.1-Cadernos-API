class BooksController < ApplicationController

  before_action :set_book, only: [:update, :destroy, :show, :set_cover]

  def index
    @books = Book.all
  end

  def show
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
  end

  def set_cover
    @book.cover_base = params[:cover_base]

    if @book.save
      render json: {success: true, book: @book}
    else
      render json: {success: false, errors: @book.errors}
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :user_id)
    end

end
