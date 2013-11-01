class User < ActiveRecord::Base
  belongs_to :referees
  belongs_to :players
  belongs_to :contests
  
  validates :username, presence: true, uniqueness: true, :length => {:maximum=>15}
  REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, :format => { :with => REGEX }
  has_secure_password
end
