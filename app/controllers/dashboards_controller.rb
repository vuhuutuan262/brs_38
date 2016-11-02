class DashboardsController < ApplicationController
  before_action :logged_as_admin
  def index
    @requests = Request.desc_created.take Settings.take_book
    @users = User.desc_created.take Settings.take_book
  end
end
