class InspirationsController < ApplicationController
  before_action :set_inspiration, only: [:show, :update, :destroy]



  def index
    @inspirations = Inspiration.all
  end

  def show

  end

def create

  @primary = Book.find(inspiration_params[:primary_id])
  @inspirational = Book.find(inspiration_params[:inspirational_id])

  @params = {:primary_id => inspiration_params[:primary_id], :inspirational_id => inspiration_params[:inspirational_id],
     :primary_title => @primary.title, :inspirational_title => @inspirational.title}

  @inspiration = Inspiration.new(@params)

  if @inspiration.save
    render :show, status: :created, location: @inspiration
  else
    render json: @inspiration.errors, status: :unprocessable_entity
  end

end

  def set_inspiration
    @inspiration = Inspiration.find(params[:id])
  end

  def inspiration_params
    params.require(:inspiration).permit(:primary_id, :inspirational_id)
  end
end
