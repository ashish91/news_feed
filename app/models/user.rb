class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :feeds

  validates :email, uniqueness: true
end
