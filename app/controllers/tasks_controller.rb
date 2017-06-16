class TasksController < ApplicationController
  skip_before_action :authenticate_request, only: [:show, :index]
  before_action :set_task, only: [:show, :update, :destroy, :set_picture]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  def show
    @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      @task.save_file(task_params) if params[:task][:document_data]
      @task.save_image(task_params) if params[:task][:image_data]
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to action: 'show', id: @task.id
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  def set_picture
    @task.picture_base = params[:picture_base]

    if @task.save
      render json: {success: true, task: @task}
    else
      render json: {success: false, errors: @task.errors}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:category_id, :title, :content, :book_id, :user_id, :picture_base)
    end
end
