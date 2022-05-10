json.array! @feeds.each do |feed|
  json.post do
    json.title feed.post.title
    json.body feed.post.body
  end

  json.creator do
    json.name feed.creator.name
    json.email feed.creator.email
  end
  json.created_at feed.created_at
end
