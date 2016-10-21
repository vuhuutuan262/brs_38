class Category < ApplicationRecord
  has_many :books

  validates :category_name, presence: true, length: {maximum: 50}
end
