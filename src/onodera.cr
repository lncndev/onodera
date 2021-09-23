#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "redis"

# Require config
require "../config"

# Give sign of life
puts "Starting Onodera"

# Start Redis server
Process.new("redis-server")
puts "Started Redis server"
redis = Redis.new

# Require Kemal route handler
require "./onodera/routes"

# Start Kemal
Kemal::Session.config.secret = "test"
Kemal.config.env = "production"
Kemal.run
