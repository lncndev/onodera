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

get "/anime/:id" do |env|
  # Define variables
  id = env.params.url["id"]

  # Get data
  image = redis.hget("anime:" + id, "imageurl")
  title = redis.hget("anime:" + id, "title")
  description = redis.hget("anime:" + id, "description")

  # Render anime page
  render "src/views/anime.ecr", "src/views/base.ecr"
end

get "/edit/:type/:id" do |env|
  # Get existing values
  id = env.params.url["id"]
  image = redis.hget("anime:" + id, "imageurl")
  title = redis.hget("anime:" + id, "title")
  description = redis.hget("anime:" + id, "description")
  subsplease = redis.hget("anime:" + id, "subsplease")

  # Render edit page
  render "src/views/edit.ecr", "src/views/base.ecr"
end

get "/edit/:type/:id/submit" do |env|
  # Get edits
  id = env.params.url["id"]
  image = env.params.query["imageurl"]?.to_s
  title = env.params.query["title"]
  description = env.params.query["description"]?.to_s
  subsplease = env.params.query["subsplease"]?.to_s

  # Get rid of old search term for proper data hygiene
  redis.del("anime:" + redis.hget("anime:" + id, "title").to_s.downcase + ":id")

  # Check if already exists
  if redis.hget("anime:" + id, "title") == nil
    # Increment nextid for anime
    redis.incrby("animenextid", 1)
  end

  # Submit edits
  #redis.hset("anime:" + id, "imageurl", image)
  redis.hset("anime:" + id, "title", HTML.escape(title))
  redis.hset("anime:" + id, "description", HTML.escape(description))
  redis.hset("anime:" + id, "subsplease", subsplease)
  redis.set("anime:" + HTML.escape(title).to_s.downcase + ":id", id.to_s)

  # Redirect back to anime page
  env.redirect("/anime/" + id)
end
