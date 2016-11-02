class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  enum mark_type: [:reading, :read, :unread]
end
