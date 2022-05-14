class User < ApplicationRecord
  has_many :party_users, dependent: :destroy
  has_many :parties, through: :party_users
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, require: true

  has_secure_password 
  
  def host_parties
    parties.where(party_users: { is_host: true })
  end

  def viewer_parties
    parties.where(party_users: { is_host: false })
  end

  def self.not_host(user_id)
    User.where.not(id: user_id)
  end
end
