class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :destroy]

  def index
    @users = User.all.order(created_at: :DESC)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def if_not_admin
    redirect_to root_path, notice: "管理者以外は管理画面にアクセスできません" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

end
