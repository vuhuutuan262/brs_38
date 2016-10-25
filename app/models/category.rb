class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :category_name, presence: true, length: {maximum: 50}
end
