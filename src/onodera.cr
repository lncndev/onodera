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

# Initialize database
redis = Redis.new

# Give sign of life
puts "Starting Onodera"

# Require Kemal route handler
require "./onodera/routes"

# Start Kemal
Kemal::Session.config.secret = "test"
Kemal.config.env = "production"
Kemal.run
