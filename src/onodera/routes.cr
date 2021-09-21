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