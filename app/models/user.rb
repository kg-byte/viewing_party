class User < ApplicationRecord
  has_many :party_users, dependent: :destroy
  has_many :parties, through: :party_users
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest, require: true
  has_secure_password

  enum role: %w[default admin]

  def past_parties
    parties.find_all { |party| Time.parse(party.time) < Time.now }
  end

  def upcoming_parties
    parties.find_all { |party| Time.parse(party.time) >= Time.now }
  end

  def all_friends
    friends + inverse_friends
  end

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
      u.name = response[:info][:name]
      u.email = response[:info][:email]
      u.password = SecureRandom.hex(15)
    end
  end
end
