#
# Onodera
#   Anime and manga database
#
#   lncndev 2021
#

# Require dependencies
require "kemal"
require "redis"
require "random/secure"
require "crypto/bcrypt/password"
require "time"

# Initialize database
redis = Redis.new

get "/auth" do |env|
  render "src/views/auth.ecr"
end

get "/auth/endpoint" do |env|
  # Get params
  username = env.params.query["username"].to_s
  password = env.params.query["password"].to_s

  token = Random::Secure.random_bytes(128)

  if redis.sismember("users", username)

    # Check if password matches hash
    if Crypto::Bcrypt::Password.create(password).to_s == redis.hget("user:" + username, "password_hash").to_s

        # Set token on server
        redis.hset("user:" + username, "token", token.to_s)
      
        # Set token on client
        env.session.string("token", redis.hset("user:" + username, "token", token.to_s).to_s)

      # Close window after auth complete
      "<script>window.close()</script>"
    else
      "Bad password"
    end

  else

    hash = Crypto::Bcrypt::Password.create(password).to_s

    redis.sadd("users", username)
    redis.hset("user:" + username, "password_hash", hash)

  end
end
