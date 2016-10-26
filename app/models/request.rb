class Request < ApplicationRecord
  belongs_to :user

  validates :book_name, presence: true, length: {maximum: 50}
  validates :author, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 60}
  validates :publish_date, presence: true
  enum status: [:waiting, :accept, :deny]
end
