class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  PER = 5

  def index
    @users = User.select(:id, :name, :admin).order(created_at: :DESC)
  end

  def show
    @tasks = @user.tasks.order(created_at: :DESC).page(params[:page]).per(PER)

  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
    else
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」は削除できません。管理者ユーザは最低1つ必要です。"
    end
  end

  private

  def if_not_admin
    unless current_user && current_user.admin == true
      flash[:notice] = t("管理者以外は管理画面にアクセスできません")
      redirect_to(tasks_path)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
