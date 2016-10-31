class Book < ApplicationRecord
  belongs_to :category, optional: true

  has_many :book_marks, dependent: :destroy
  has_many :review_rates, dependent: :destroy

  mount_uploader :cover, PictureUploader

  validates :title, presence: true, length: {maximum: 140}
  validates :number_of_page,
    numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :author, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 200}
  validates :category, presence: true

  scope :order_desc, -> {order created_at: :desc}
  scope :order_desc_rate, -> {order avg_rates: :desc}
  scope :publish_date_order_desc, ->{order publish_date: :desc}

  def self.search search
    if search
      where(["title LIKE ? or
        number_rate_of_book LIKE ? or
        author LIKE ? or
        number_of_page = ? or avg_rates = ?",
        "%#{search}%", "%#{search}%", "%#{search}%", search, search])
    else
      all
    end
  end
end
