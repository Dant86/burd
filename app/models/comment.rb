class Comment < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :commenters, class_name: :User, foreign_key: :user_id
  belongs_to :posts
end
