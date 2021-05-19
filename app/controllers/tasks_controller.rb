class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  PER = 5

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(expired_at: :DESC).page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :DESC).page(params[:page]).per(PER)
    elsif params[:search]
      if params[:search_title].present? && params[:search_status].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status]).page(params[:page]).per(PER)
      elsif params[:search_title].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).page(params[:page]).per(PER)
      elsif params[:search_status].present?
        @tasks = current_user.tasks.search_status(params[:search_status]).page(params[:page]).per(PER)
      else
        @tasks = current_user.tasks.all.order(created_at: :DESC).page(params[:page]).per(PER)
      end
    else
      @tasks = current_user.tasks.all.order(created_at: :DESC).page(params[:page]).per(PER)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end


