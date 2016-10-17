class Comment < ApplicationRecord
  belongs_to :review_rate
  belongs_to :user
end
