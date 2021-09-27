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
  image = redis.hget("anime:" + id, "image")
  title = redis.hget("anime:" + id, "title")
  description = redis.hget("anime:" + id, "description")
  characters = redis.smembers("anime:" + id + ":characters")

  # Render anime page
  render "src/views/anime.ecr", "src/views/base.ecr"
end

get "/character/:id" do |env|
  # Define variables
  id = env.params.url["id"]

  # Get data
  image = redis.hget("character:" + id, "image")
  name = redis.hget("character:" + id, "name")
  bio = redis.hget("character:" + id, "bio")

  # Render anime page
  render "src/views/character.ecr", "src/views/base.ecr"
end

get "/edit/:type/:id" do |env|
  type = env.params.url["type"]
  id = env.params.url["id"]

  image = redis.hget(type + ":" + id, "image")

  case type
  when "anime"
    title = redis.hget("anime:" + id, "title")
    description = redis.hget("anime:" + id, "description")
    subsplease = redis.hget("anime:" + id, "subsplease")
  when "character"
    name = redis.hget("character:" + id, "name")
    bio = redis.hget("character:" + id, "bio")
  end

  # Render edit page
  render "src/views/edit.ecr", "src/views/base.ecr"
end

get "/edit/:type/:id/submit" do |env|
  type = env.params.url["type"]

  # Get edits
  id = env.params.url["id"]
  image = env.params.query["image"]?.to_s

  case type
  when "anime"
    title = env.params.query["title"].to_s
    description = env.params.query["description"]?.to_s
    subsplease = env.params.query["subsplease"]?.to_s
  when "character"
    name = env.params.query["name"].to_s
    bio = env.params.query["bio"]?.to_s
    sourceid = env.params.query["sourceid"].to_s
    sourcetype = env.params.query["sourcetype"].to_s
  end

  # Get rid of old search term for proper data hygiene
  redis.del(type + ":" + redis.hget(type + ":" + id, case type; when "anime"; "title"; when "character"; "name"; end).to_s.downcase + ":id")

  # Check if already exists
  if redis.hget(type + ":" + id, "title") == nil
    # Increment nextid for anime
    redis.incrby(type + "nextid", 1)
  end

  # Submit edits
  case type
  when "anime"
    redis.hset("anime:" + id, "image", HTML.escape(image.to_s))
    redis.hset("anime:" + id, "title", HTML.escape(title.to_s))
    redis.hset("anime:" + id, "description", HTML.escape(description.to_s))
    redis.hset("anime:" + id, "subsplease", subsplease)
    redis.set("anime:" + HTML.escape(title.to_s).to_s.downcase + ":id", id.to_s)
    redis.incrby("animenextid", 1)
    env.redirect("/anime/" + id)
  when "character"
    redis.hset("character:" + id, "image", HTML.escape(image.to_s))
    redis.hset("character:" + id, "name", HTML.escape(name.to_s))
    redis.hset("character:" + id, "bio", HTML.escape(bio.to_s))
    redis.set("character:" + HTML.escape(name.to_s).to_s.downcase + ":id", id.to_s)
    redis.sadd(sourcetype.to_s + ":" + sourceid.to_s + ":" + "characters", id.to_s)
    redis.incrby("characternextid", 1)
    env.redirect("/" + sourcetype.to_s + "/" + sourceid.to_s)
  end

end