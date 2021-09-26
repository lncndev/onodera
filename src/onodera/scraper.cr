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
require "../config"

# Initialize database
redis = Redis.new

get "/scrape" do |env|
    render "src/views/scrape.ecr", "src/views/base.ecr"
end

post "/scrape/:type/submit" do |env|
    mal_id = env.params.body["id"]
    scrape_type = env.params.url["type"].to_s

    case scrape_type
    when "anime"
        Jikan.anime(mal_id)
    end
end