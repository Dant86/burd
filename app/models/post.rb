class Post < ActiveRecord::Base
  # Remember to create a migration!
  has_many :likes
  has_many :comments
  has_many :upvoters, through: :likes, foreign_key: :user_id
  has_many :commenters, through: :comments, foreign_key: :user_id
end
