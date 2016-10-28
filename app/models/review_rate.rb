class ReviewRate < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: {minimum: 200, maximum: 5000}
  validates :number_rate_of_user, numericality: {greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5, only_integer: true}
  validates :book, presence: true

  scope :desc, ->{order created_at: :DESC}

  def self.avg_rate book_id
    ReviewRate.where("book_id = ?", book_id).
      group(:book_id).average(:number_rate_of_user)
  end
end
