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

# Version number and name
VERSION_NUMBER = "0.1"
VERSION_NAME = "Mami"

# Give sign of life
puts "Starting Onodera"

# Start Redis server
Process.new("redis-server")
puts "Started Redis server"
redis = Redis.new

# Require Kemal route handler
require "./onodera/routes"

# Start Kemal
Kemal.config.env = "production"
Kemal.run