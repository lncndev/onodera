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

require "./auth"

require "./pages"

get "/search" do |env|
  results = redis.keys("anime:*" + env.params.query["q"].downcase + "*:id")
  render "src/views/search.ecr", "src/views/base.ecr"
end