#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "json"
require "redis"

# Initialize database
redis = Redis.new

get "/" do |env|
  # Render home page
  render "src/views/home.ecr"
end

get "/api/:action" do |env|
  # Get "action" URL param
  action = env.params.url["action"]

  # Render response
  render "src/views/api.ecr"
end

get "/anime/:id" do |env|
  # Render anime page
  render "src/views/anime.ecr"
end

get "/edit/:type/:id" do |env|
  # Render edit page
  render "src/views/edit.ecr"
end

get "/edit/:type/:id/submit" do |env|
  # Get edits
  id = env.params.url["id"]
  title = env.params.query["title"]
  description = env.params.query["description"]

  # Submit edits
  redis.hset("anime:" + id, "title", title)
  redis.hset("anime:" + id, "description", description)
end
