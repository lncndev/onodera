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

# Initialize database
redis = Redis.new

get "/auth" do |env|
  render "src/views/auth.ecr"
end

post "/auth" do |env|
  # Get POST params
  username = env.params.body["username"]
  password = env.params.body["password"]
  token = Random::Secure.random_bytes(128)

  if redis.sismember("users", username)
    # Get password hash
    password_hash = Crypto::Bcrypt::Password.new(redis.hget("user:" + username, "password_hash").to_s)

    # Check if password matches hash
    if password_hash.verify(password)
      # Close window after auth complete
      "<script>window.close()</script>"
    else
      "Bad password"
    end
  else
    hash = Crypto::Bcrypt::Password.create(password)

    redis.sadd("users", username)
    redis.hset("user:" + username, "password_hash", hash)
    redis.hset("user:" + username, "password_salt", hash.salt)
  end
end
