class CelebrityFeedManagerService
  CELEBRITY_FRIEND_COUNT = 3.freeze

  def initialize(user_id:)
    @user = User.find_by(id: user_id)
  end

  def create_celebrity_feeds_for_user
    return if @user.nil?

    get_celebrities.each do |celebrity|
      new_posts_by_celebrity(celebrity: celebrity).each do |post_id|
        Feed.create!(
          post_id: post_id,
          user_id: @user.id,
          creator_id: celebrity.id
        )
      end
    end
  end

  def get_celebrities
    @user.friends.where("friend_count > #{CELEBRITY_FRIEND_COUNT}")
  end

  def new_posts_by_celebrity(celebrity:)
    existing_posts = Feed.where(user_id: @user.id, creator_id: celebrity.id).pluck(:post_id)
    celebrity.posts.where.not(id: existing_posts).pluck(:id)
  end
end
