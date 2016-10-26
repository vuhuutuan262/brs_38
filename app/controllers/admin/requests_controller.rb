class Admin::RequestsController < ApplicationController
  before_action :logged_as_admin
  before_action :find_request, only: [:edit, :update, :destroy]
  before_action :load_status, only: :edit

  def index
    @requests = Request.order(id: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "controllers.admin.requests.action_success"
      redirect_to admin_requests_path
    else
      load_status
      render :edit
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "controllers.admin.requests.destroy_success"
    else
      flash[:danger] = t "controllers.admin.requests.error_destroy"
    end
    redirect_to admin_requests_url
  end

  private
  def request_params
    params.require(:request).permit :status
  end

  def find_request
    @request = Request.find_by id: params[:id]
    if @request.blank?
      flash[:danger] = t "controller.admin.requests.not_find"
      redirect_to admin_requests_url
    end
  end

  def load_status
    @request_statuses = Request.statuses.map{|key, value| [key, key]}
  end
end
