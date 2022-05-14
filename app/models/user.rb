class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :posts, class_name: "Post", foreign_key: "creator_id"

  has_many :feeds

  validates :email, uniqueness: true

  def celebrity?
    friend_count > CelebrityFeedManagerService::CELEBRITY_FRIEND_COUNT
  end
end
