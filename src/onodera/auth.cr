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
  render "src/views/auth.ecr", "src/views/base.ecr"
end

post "/auth/endpoint" do |env|
  # Get params
  username = env.params.body["username"]
  password = env.params.body["password"]

  token = Random::Secure.random_bytes(128)

  "Authenticating..."

  if redis.sismember("users", username) == 1
    # Check if password matches hash
    if Crypto::Bcrypt::Password.new(redis.hget("user:" + username, "password_hash").to_s).verify(password) == true
      # Set token on server
      redis.hset("user:" + username, "token", token.to_s)
      redis.hset("usertokens", token.to_s, username)

      # Set token on client
      env.session.string("token", redis.hget("user:" + username, "token").to_s)

      # TODO: Redirect after auth complete
      env.redirect("/")
    else
      "Bad password"
    end
  else
    # Hash password
    hash = Crypto::Bcrypt::Password.create(password).to_s

    # Add new user to database
    redis.sadd("users", username.to_s)
    redis.hset("user:" + username.to_s, "password_hash", hash)

    # Set token on server
    redis.hset("user:" + username, "token", token.to_s)
    redis.hset("usertokens", token.to_s, username)

    # Set token on client
    env.session.string("token", redis.hget("user:" + username, "token").to_s)

    # Redirect after auth complete
    env.redirect("/")
  end
end
