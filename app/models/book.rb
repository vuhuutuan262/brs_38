class Book < ApplicationRecord
  belongs_to :category

  has_many :book_marks, dependent: :destroy
  has_many :review_rates, dependent: :destroy

  mount_uploader :cover, PictureUploader

  validates :title, presence: true, length: {maximum: 140}
  validates :number_of_page,
    numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :author, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 200}

  scope :order_desc, -> {order created_at: :DESC}

end
