module ActivityConcern
  extend ActiveSupport::Concern

  def create_activity activity_type, start_id, target_id
    @activity = Activity.new activity_type:
      activity_type, target_id: target_id
      @activity.user_id = start_id
    @activity.save
  end

  def remove_activity activity_type, start_id, target_id
    @activity = Activity.find_by user_id: start_id,
      activity_type: activity_type, target_id: target_id
    @activity.destroy
  end
end
