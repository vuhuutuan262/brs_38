class Book < ApplicationRecord
  belongs_to :category

  has_many :book_marks, dependent: :destroy
  has_many :review_rates, dependent: :destroy
end
