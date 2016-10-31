class Activity < ApplicationRecord
  belongs_to :user

  enum activity_type: [:review, :comment, :follow, :read, :favorite]

  scope :desc, -> {order created_at: :desc}

  def target_activity
    if review?
      review = ReviewRate.find_by id: target_id
      review.book
    elsif follow?
      User.find_by id: target_id
    elsif comment?
      comment = Comment.find_by id: target_id
      comment.review_rate
    else
      Book.find_by id: target_id
    end
  end

  def content
    case activity_type
      when "review"
        I18n.t "activity.review_timeline"
      when "follow"
        I18n.t "activity.follow_timeline"
      when "comment"
        I18n.t "activity.comment_timeline"
      when "read"
        I18n.t "activity.read_timeline"
      when "favorite"
        I18n.t "activity.favorite_timeline"
      end
  end
end
