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
  release_year = redis.hget("anime:" + id, "releaseyear")
  age_rating = redis.hget("anime:" + id, "agerating")

  case age_rating
  when "G/PG"
    age_rating_badge_color = "success"
  when "PG-13/TV-14"
    age_rating_badge_color = "primary"
  when "R"
    age_rating_badge_color = "warning"
  when "MA/TV-MA"
    age_rating_badge_color = "warning"
  when "Hentai"
    age_rating_badge_color = "danger"
  end

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
    image = redis.hget("anime:" + id, "image")
    releaseyear = redis.hget("anime:" + id, "releaseyear")
    agerating = redis.hget("anime:" + id, "agerating")
  when "character"
    name = redis.hget("character:" + id, "name")
    bio = redis.hget("character:" + id, "bio")
    image = redis.hget("character:" + id, "image")
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
    image = env.params.query["image"]?.to_s
    releaseyear = env.params.query["releaseyear"]?.to_s
    mal = env.params.query["mal"]?.to_s
    agerating = env.params.query["agerating"]?.to_s
  when "character"
    name = env.params.query["name"].to_s
    bio = env.params.query["bio"]?.to_s
    image = env.params.query["image"]?.to_s
    sourceid = env.params.query["sourceid"].to_s
    sourcetype = env.params.query["sourcetype"].to_s
  end

  # Get rid of old search term for proper data hygiene
  redis.del(type + ":" + redis.hget(type + ":" + id, case type
  when "anime"    ; "title"
  when "character"; "name"
  end).to_s.downcase + ":id")

  # Submit edits
  case type
  when "anime"
    Onodera::Edit.anime(id, title, description, image, subsplease, releaseyear, mal, agerating)
    env.redirect("/anime/" + id)
  when "character"
    Onodera::Edit.character(id, name, sourcetype, sourceid, bio, image)
    env.redirect("/" + sourcetype.to_s + "/" + sourceid.to_s)
  end
end