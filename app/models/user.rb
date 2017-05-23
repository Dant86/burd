require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts
  has_many :likes
  has_many :comments

  validates :username,  presence: true
  validates :username, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(username,entered_password)
  	@user = User.find_by(username: username)
  	if @user.password == entered_password
  		return @user
  	end
  end
end
