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

module Onodera
  class Is
    def self.authed
      redis = Redis.new
      if env.session.string?("token") != nil
        true
      else
        false
      end
    end

    def self.admin
      redis = Redis.new
      if redis.hget("usertokens", env.session.string("token").to_s) == ONODERA_ADMIN
        true
      else
        false
      end
    end
  end

  class Edit
    def self.anime(id, title, description = nil, image = nil, subsplease = nil, releaseyear = nil, mal = nil, agerating = nil)
      redis = Redis.new
      id = id.to_s
      redis.hset("anime:" + id, "title", HTML.escape(title.to_s))
      redis.hset("anime:" + id, "description", HTML.escape(description.to_s))
      redis.hset("anime:" + id, "subsplease", HTML.escape(subsplease.to_s))
      redis.hset("anime:" + id, "image", HTML.escape(image.to_s))
      redis.hset("anime:" + id, "releaseyear", HTML.escape(releaseyear.to_s))
      redis.hset("anime:" + id, "mal", HTML.escape(mal.to_s))
      redis.hset("anime:" + id, "agerating", HTML.escape(agerating.to_s))
      redis.set("anime:" + HTML.escape(title.to_s).to_s.downcase + ":id", id.to_s)
      redis.incrby("animenextid", 1)
    end

    def self.character(id, name, sourcetype, sourceid, bio = nil, image = nil, mal = nil)
      redis = Redis.new
      redis.hset("character:" + id, "name", HTML.escape(name.to_s))
      redis.hset("character:" + id, "bio", HTML.escape(bio.to_s))
      redis.hset("character:" + id, "mal", HTML.escape(mal.to_s))
      redis.hset("character:" + id, "image", HTML.escape(image.to_s))
      redis.set("character:" + HTML.escape(name.to_s).to_s.downcase + ":id", id.to_s)
      redis.sadd(sourcetype.to_s + ":" + sourceid.to_s + ":" + "characters", id.to_s)
      redis.incrby("characternextid", 1)
    end
  end
end
