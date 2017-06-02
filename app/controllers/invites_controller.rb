class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request

  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
  end

  # POST /invites
  # POST /invites.json
  def create
    @user = User.find_by_email(invite_params[:email])

    puts "="*80
    puts @user.id
    puts "="*80

    @params = {:sender_id => invite_params[:sender_id], :recipient_id => @user.id, :book_id => invite_params[:book_id], :email => invite_params[:email]}

    @invite = Invite.new(@params)

    if @invite.save
      render :show, status: :created, location: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invites/1
  # PATCH/PUT /invites/1.json
  def update
    if @invite.update(invite_params)
      render :show, status: :ok, location: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
      params.require(:invite).permit(:email, :sender_id, :book_id)
    end
end
