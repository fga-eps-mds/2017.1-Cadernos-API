class UsersController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_user, only: [:show, :update, :destroy, :books]


  # GET /users
  def index

    exclude_columns = ['password_digest']
    columns = User.attribute_names - exclude_columns
    @users = User.select(columns).all

    render json: @users
  end

  # GET /users/1
  def show
    exclude_columns = ['password_digest']
    columns = User.attribute_names - exclude_columns
    @user = User.select(columns).find(params[:id])
    render json: @user
  end

  def books
    @books = @user.books.all
    render json: @books
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to action: 'index', status:200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params

      params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation)

    end
end
