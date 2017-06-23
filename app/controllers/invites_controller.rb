class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :update, :destroy]


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
    @book = Book.find(invite_params[:book_id])
    @sender = User.find(invite_params[:sender_id])

    if @user != nil
      @params = {:sender_id => invite_params[:sender_id], :recipient_id => @user.id,
                  :book_id => invite_params[:book_id], :email => invite_params[:email],
                  :book_title => @book.title, :sender_name => @sender.name, :recipient_name => @user.name}
    else
      @params = {:sender_id => invite_params[:sender_id], :recipient_id => nil,
                  :book_id => invite_params[:book_id], :email => invite_params[:email],
                  :book_title => @book.title, :sender_name => @sender.name, :recipient_name => nil}
    end

    @invite = Invite.new(@params)

    if @invite.save
      ActionMailer::Base.mail(from: "ColaborArt APP <colaborart_api@reborn.com>",
                              to: "victor_cmoura@hotmail.com",
                              subject: "Convite para colaboração em " + @book.title,
                              body: "Olá, " + @user.name + "!\n" + @sender.name + " te convidou para colaborar em " + @book.title + ". Acesse o APP para aceitar!").deliver

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
