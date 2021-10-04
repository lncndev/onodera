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

# Require init script
require "./onodera/init"

# Require helpers
require "./onodera/helpers"

# Require task handler
require "./onodera/tasks"

module Onodera; end

# Give sign of life
puts "Starting Onodera"

# Require Kemal route handler
require "./onodera/routes"

# Start Kemal
Kemal::Session.config.secret = "test"
Kemal.config.env = "production"
Kemal.run