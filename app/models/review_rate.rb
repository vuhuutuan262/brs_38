class ReviewRate < ApplicationRecord
  include ActivityConcern
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: {minimum: 200, maximum: 5000}
  validates :number_rate_of_user, numericality: {greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5, only_integer: true}
  validates :book, presence: true

  after_save :create_activity_for_review
  before_destroy :remove_activity_for_review

  scope :desc, -> {order created_at: :DESC}

  def self.avg_rate book_id
    ReviewRate.where("book_id = ?", book_id).
      group(:book_id).average(:number_rate_of_user)
  end

  def create_activity_for_review
    create_activity Activity.activity_types[:review], self.user_id, self.id
  end

  def remove_activity_for_review
    remove_activity Activity.activity_types[:review], self.user_id, self.id
  end
end
