class CreateFeedForFriendJob
  include Sidekiq::Job

  def perform(creator_id, friend_id)
    return unless User.exists?(creator_id) and User.exists?(friend_id)
    user = User.find(creator_id)

    existing_posts = Feed.where(user_id: friend_id).pluck(:post_id)
    posts = user.posts.where.not(id: existing_posts).pluck(:id)
    return if posts.blank?

    puts "Started creating feed for friend #{friend_id} for #{user.name}"
    posts.each do |post_id|
      puts "Create feed for post #{post_id}"
      Feed.create!(
        user_id: friend_id,
        post_id: post_id,
        creator_id: creator_id
      )
    end
    puts "Feed creation complete for #{user.name}"
  end
end
