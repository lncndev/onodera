#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "redis"
require "../../config"

# Initialize database
redis = Redis.new

macro onohelp_is_admin
    if redis.hget("usertokens", env.session.string("token").to_s) == ONODERA_ADMIN
        true
    else
        false
    end
end

macro onohelp_is_authenticated
    if env.session.string?("token") != nil
        true
    else
        false
    end
end
