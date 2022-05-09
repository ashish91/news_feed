class CreateFeedForUserJob
  include Sidekiq::Job

  def perform(creator_id, post_id)
    return unless User.exists?(creator_id) and Post.exists?(post_id)
    user = User.find(creator_id)

    friends = user.friends.pluck(:id)
    return if friends.nil?

    friends.each do |friend_id|
      Feed.create!(
        user_id: friend_id,
        post_id: post_id,
        creator_id: creator_id
      )
    end
  end
end
