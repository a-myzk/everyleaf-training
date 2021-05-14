class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    # @tasks = Task.all.order(id: :DESC)
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: :DESC)
    # elsif params[:sort_priority]
    #   @tasks = Task.all.order(id: :DESC)
    elsif params[:search]
      if params[:search_title].present?
        # @tasks = Task.where('title like ?', "%#{params[:search_title]}%")
        @tasks = tasks.search_title(params[:search_title])
      else
        @tasks = Task.all
      end
    else
      @tasks = Task.all.order(id: :DESC)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    #@task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを新規登録しました"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status)
  end
end


