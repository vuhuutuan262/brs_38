class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :like_activities, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :review_rates, dependent: :destroy
  has_many :relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
