#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "redis"
require "kemal-session"
require "html"

# Require helpers
require "./helpers"

# Initialize database
redis = Redis.new

get "/" do |env|
  # Render home page
  render "src/views/home.ecr", "src/views/base.ecr"
end

get "/api/:action" do |env|
  # Get "action" URL param
  action = env.params.url["action"]

  # Render response
  render "src/views/api.ecr", "src/views/base.ecr"
end

get "/anime/:id" do |env|
  # Define variables
  id = env.params.url["id"]

  # Get data
  title = redis.hget("anime:" + id, "title")
  description = redis.hget("anime:" + id, "description")

  # Render anime page
  render "src/views/anime.ecr", "src/views/base.ecr"
end

get "/edit/:type/:id" do |env|
  # Get existing values
  id = env.params.url["id"]
  title = redis.hget("anime:" + id, "title")
  description = redis.hget("anime:" + id, "description")

  # Render edit page
  render "src/views/edit.ecr", "src/views/base.ecr"
end

get "/edit/:type/:id/submit" do |env|
  # Get edits
  id = env.params.url["id"]
  title = env.params.query["title"]
  description = env.params.query["description"]

  # Get rid of old search term for proper data hygiene
  redis.del("anime:" + redis.hget("anime:" + id, "title").to_s.downcase + ":id")

  # Submit edits
  redis.hset("anime:" + id, "title", HTML.escape(title))
  redis.hset("anime:" + id, "description", HTML.escape(description))
  redis.set("anime:" + HTML.escape(title).to_s.downcase + ":id", id.to_s)

  # Redirect back to anime page
  env.redirect("/anime/" + id)
end

require "./auth"

get "/search" do |env|
  results = redis.keys("anime:*" + env.params.query["q"].downcase + "*:id")
  render "src/views/search.ecr", "src/views/base.ecr"
end
