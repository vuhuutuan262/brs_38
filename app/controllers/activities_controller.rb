class ActivitiesController < ApplicationController
  before_action :logged_in_user

  def index
    @activities = Activity.desc.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
