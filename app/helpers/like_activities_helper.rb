module LikeActivitiesHelper
  def create_like activity
    @like = if current_user.liked? activity
      current_user.like_activities.find_by activity_id: activity.id
    else
      current_user.like_activities.build
    end
  end
end
