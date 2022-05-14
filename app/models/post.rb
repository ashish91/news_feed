class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  after_commit :create_feed_for_friends, on: :create

  private
    def create_feed_for_friends
      # For celebrity the feed is generated when
      # the user fetches the feed
      if !creator.celebrity?
        CreateFeedForPostJob.new.perform(creator_id, id)
      end
    end
end
