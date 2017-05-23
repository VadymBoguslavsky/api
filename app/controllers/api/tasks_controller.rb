class Api::TasksController < ApiController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :doorkeeper_authorize!

  def index
    @tasks = current_user.tasks
    render json: @tasks
  end

  def show
    render json: @task
  end


  def create
    @task=current_user.tasks.build(task_params)
    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  def batch_destroy
    @ids = params[:tasks]

    if @ids && @ids.kind_of?(Array)
      @tasks = current_user.tasks.where(id: @ids)
      if @tasks.delete_all
        render json: @ids
      else
        render json: {
          message: 'Could not delete tasks',
          errors: @task.errors.full_messages
        }, status: 500
      end
    else
      render json: {
        message: 'Invalid params'
      }, status: 422
    end
  end


  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit!
  end
end