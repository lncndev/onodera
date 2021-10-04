#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "redis"

# Initialize database
redis = Redis.new

# Check if initialized or not
if redis.get("initstatus") == nil
  # Set variables if not already initialized
  redis.set("animenextid", 0)
  redis.set("characternextid", 0)
  redis.set("initstatus", 1)
end
