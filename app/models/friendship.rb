class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_commit :create_feed_for_friend, on: :create
  after_commit :increment_friend_count

  private
    def create_feed_for_friend
      CreateFeedForFriendJob.new.perform(user_id, friend_id)
    end

    def increment_friend_count
      Friendship.transaction(isolation: :read_committed) do
        User.where(id: user.id).update_all("friend_count = friend_count + 1")
      end
    end
end
