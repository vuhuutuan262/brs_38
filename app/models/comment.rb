class Comment < ApplicationRecord
  include ActivityConcern
  belongs_to :review_rate
  belongs_to :user

  validates :content, presence: true, length: {maximum: 200}

  after_save :create_activity_for_comment
  before_destroy :remove_activity_for_comment

  scope :desc, -> {order created_at: :desc}

  def create_activity_for_comment
    create_activity Activity.activity_types[:comment], self.user_id, self.id
  end

  def remove_activity_for_comment
    remove_activity Activity.activity_types[:comment], self.user_id, self.id
  end
end
