class Admin::UsersController < ApplicationController
  before_action :logged_as_admin, only: [:index, :destroy]
  before_action :find_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.flash.destroy_success"
    else
      flash[:danger] = t "controllers.flash.destroy_error"
    end
    redirect_to admin_users_url
  end

  private
  def find_user
    @user= User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "flash.find_user_fail"
      redirect_to root_path
    end
  end
end
