class FeedFetchService
  def initialize(user_id:)
    @user_id = user_id
  end

  def latest
    return [] unless User.exists?(@user_id)
    CelebrityFeedManagerService.new(user_id: @user_id).create_celebrity_feeds_for_user

    Feed.latest.where(user_id: @user_id)
  end
end
