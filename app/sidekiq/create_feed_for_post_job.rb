class CreateFeedForPostJob
  include Sidekiq::Job

  def perform(creator_id, post_id)
    return unless User.exists?(creator_id) and Post.exists?(post_id)
    user = User.find(creator_id)

    friends = user.friends.pluck(:id)
    return if friends.blank?

    puts "Started creating feed for post #{post_id} for #{user.name}"
    friends.each do |friend_id|
      puts "Create feed for friend #{friend_id}"
      Feed.create!(
        user_id: friend_id,
        post_id: post_id,
        creator_id: creator_id
      )
    end
    puts "Feed creation complete for #{user.name}"
  end
end
