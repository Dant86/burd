class Like < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :upvoters, class_name: :User, foreign_key: :user_id
  belongs_to :post
end
