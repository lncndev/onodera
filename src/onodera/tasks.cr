#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "redis"
require "mosquito"
require "jikancr"

# Require config
require "../../config"

# Require helpers
require "./helpers"

# Initialize database
redis = Redis.new

Mosquito.configure do |settings|
    settings.redis_url = "redis://localhost:6379/1"
end

class ScrapeTasks < Mosquito::PeriodicJob
  run_every 4.seconds

  def perform
    redis = Redis.new
    scrape_task = redis.smembers("scrapetasks")[0]

    mal_data = Jikan.anime(scrape_task)
    Onodera::Edit.anime(redis.get("animenextid"), mal_data["title"], mal_data["synopsis"].to_s.gsub("—", "---"), mal_data["image_url"], "https://duckduckgo.com/" + mal_data["title"].to_s + " SubsPlease", mal_data["premiered"].to_s, mal_data["mal_id"])

    redis.srem("scrapetasks", scrape_task)
  end
end

spawn do
Mosquito::Runner.start
end
