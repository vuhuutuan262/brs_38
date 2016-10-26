class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_request, only: [:destroy]

  def index
    @requests = current_user.requests.order(id: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t "controllers.requests.create_success"
      redirect_to requests_url
    else
      render :new
    end
  end

  def destroy
    if @request && @request.destroy
      flash[:success] = t "controllers.requests.destroy_success"
    else
      flash[:danger] = t "controllers.requests.destroy_error"
    end
    redirect_to requests_url
  end

  private
  def request_params
    params.require(:request).permit :book_name, :author, :content
  end

  def load_request
    @request = Request.find_by id: params[:id]
  end
end
