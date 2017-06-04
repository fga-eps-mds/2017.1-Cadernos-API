class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :update, :destroy]


  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # POST /memberships
  # POST /memberships.json
  def create

    @user = User.find_by_email(membership_params[:email])
    @book = Book.find(membership_params[:book_id])
    @owner = User.find(@book.user_id)

    @params = {:email => membership_params[:email], :member_id => @user.id, :book_id => membership_params[:book_id],
                :book_title => @book.title, :book_owner_name => @owner.name, :member_name => @user.name}

    @membership = Membership.new(@params)

    if @membership.save
      render :show, status: :created, location: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    if @membership.update(membership_params)
      render :show, status: :ok, location: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:email, :book_id)
    end
end
