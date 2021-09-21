require "kemal"
require "json"
require "redis"

puts "Starting Onodera"

Process.new("redis-server")
puts "Started Redis server"
redis = Redis.new

require "./onodera/routes"

Kemal.config.env = "production"
Kemal.run