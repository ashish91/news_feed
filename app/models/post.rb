class Post < ApplicationRecord

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  after_commit :create_feed, on: :create

  private
    def create_feed
      CreateFeedForUserJob.new.perform(creator_id, id)
    end

end
