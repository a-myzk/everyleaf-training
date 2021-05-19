class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order(created_at: :DESC)
  end

  def show
  end

  def new
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
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
