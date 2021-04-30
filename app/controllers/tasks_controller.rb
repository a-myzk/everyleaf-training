class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    #@task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @task.save
          #ConfirmMailer.confirm_mail(@task).deliver
          format.html { redirect_to @task, notice: "タスクを新規登録しました" }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end
