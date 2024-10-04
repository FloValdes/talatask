class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update destroy ]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks.as_json(include: :abilities)
  end

  # GET /tasks/1
  def show
    render json: @task.as_json(include: :abilities)
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if params[:abilities]
      abilities = params[:abilities].map do |ability_name|
        Ability.find_or_create_by(name: ability_name)
      end
      @task.abilities = abilities
    end

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :date, :duration)
    end
end
