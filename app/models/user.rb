class User < ApplicationRecord
  has_many :party_users, dependent: :destroy
  has_many :parties, through: :party_users
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, require: true
  has_secure_password 
  
end
