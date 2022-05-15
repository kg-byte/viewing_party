class User < ApplicationRecord
  has_many :party_users, dependent: :destroy
  has_many :parties, through: :party_users
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, require: true

  has_secure_password 
  
end
