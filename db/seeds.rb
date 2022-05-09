# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Feed.delete_all
Post.delete_all

Friendship.delete_all
User.delete_all

50.times do
  User.create!(email: Faker::Internet.unique.email, name: Faker::Name.name)
end

user_ids = User.pluck(:id)
user_ids.each do |user_id|
  rand(1..10).times do
    friend_id = user_ids.sample
    Friendship.create!(friend_id: friend_id, user_id: user_id)
  end
end

user_ids.each do |user_id|
  rand(5..20).times do
    Post.create!(
      creator_id: user_id,
      title: Faker::Alphanumeric.alphanumeric(number: rand(5..15)),
      body: Faker::Alphanumeric.alphanumeric(number: rand(50..80))
    )
  end
end
