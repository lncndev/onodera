#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "redis"
require "jikancr"

# Require config
require "../../config"

# Initialize database
redis = Redis.new

get "/scrape" do |env|
  render "src/views/scrape.ecr", "src/views/base.ecr"
end

post "/scrape/:type/submit" do |env|
  mal_id = JSON.parse(Jikan.search("anime", env.params.body["query"].to_s.gsub(" ", "+")).to_s)["results"][0]["mal_id"].to_s
  scrape_type = env.params.url["type"].to_s

  case scrape_type
  when "anime"
    redis.sadd("scrapetasks", mal_id.to_s)
  end

  env.redirect("/scrape")
end