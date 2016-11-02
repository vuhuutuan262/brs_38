class BookMark < ApplicationRecord
  include ActivityConcern
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  enum mark_type: [:reading, :read, :unread]

  after_save :create_activity_for_mark_book
  before_destroy :remove_activity_for_mark_book

  def create_activity_for_mark_book
    create_activity Activity.activity_types[:read], self.user_id, self.id
  end

  def remove_activity_for_mark_book
    remove_activity Activity.activity_types[:read], self.user_id, self.id
  end
end
