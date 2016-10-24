class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "app_controller.flash_danger"
      redirect_to login_url
    end
  end

  def logged_as_admin
    unless current_user && current_user.is_admin
      flash[:danger] = t "controllers.admin.login.flash.danger"
      redirect_to login_url
    end
  end
end
