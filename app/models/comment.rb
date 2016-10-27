class Comment < ApplicationRecord
  belongs_to :review_rate
  belongs_to :user

  validates :content, presence: true, length: {maximum: 200}

  scope :desc, -> {order created_at: :desc}
end
