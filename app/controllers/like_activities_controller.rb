class LikeActivitiesController < ApplicationController
  before_action :logged_in_user
  before_action :find_activity, only: [:create, :destroy]

  def create
    @like = current_user.like_activities.build activity_id: params[:activity_id]
    if @like.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @like = LikeActivity.find_by id: params[:id]
    if @like.destroy
      respond_to do |format|
        format.html {redirect_to activities_path}
        format.js
      end
    else
      redirect_to root_path
    end

  end

  private
  def like_params
    params.require(:like_activity).permit :is_like, :activities_id
  end

  def find_activity
    @activity = Activity.find_by id: params[:activity_id]
    if @activity.nil?
      redirect_to root_path
    end
  end
end
