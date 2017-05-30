class BooksController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :full_detail, :tasks]
  before_action :set_book, only: [:update, :destroy, :show, :set_cover, :tasks, :full_detail]

  def index
    @books = Book.paginate(:page => params[:page], :per_page => params[:per_page] || 10).order('title ASC')
  end

  def show
  end

  def full_detail
    @tasks = get_book_tasks
    @categories = Category.joins(:tasks).where("book_id = ?", @book.id).distinct
  end

  def tasks
    @tasks = get_book_tasks
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

    def get_book_tasks
      @book.tasks.includes(:user).paginate(:page => params[:page], :per_page => params[:per_page] || 10).order('title ASC')
    end
end
