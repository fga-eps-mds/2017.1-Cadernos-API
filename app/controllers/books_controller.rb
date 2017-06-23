include Rails.application.routes.url_helpers

class BooksController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :all, :show, :full_detail, :tasks, :search, :inspirations, :createEbook]
  before_action :set_book, only: [:update, :destroy, :show, :set_cover, :tasks, :full_detail, :members, :inspirations, :createEbook]
  helper_method :add_host_prefix

  def index
    @books = Book.includes(:user).paginate(:page => params[:page], :per_page => params[:per_page] || 10).order('title ASC')
  end

  def all
    @books = Book.includes(:user).all.order('id ASC')
    render :index
  end

  def search
    keyword = params[:keyword]
    @books = Book.where("title ILIKE '%#{keyword}%'")
    render json: @books
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

  def members
    @members = @book.members.all
  end

  def inspirations
    @inspirations = @book.inspirations.all
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

  def createEbook
    html_path = Rails.root.join('app','views','books','ebook.html.erb')
    html_string = render_to_string file: html_path
    pdf = WickedPdf.new.pdf_from_string(html_string)
    #render html: html_string.html_safe
     send_data pdf
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

    def add_host_prefix(url)
      URI.join(Rails.configuration.my_root_url, url).to_s
    end
end
