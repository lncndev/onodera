require "kemal"
require "json"
require "redis"
redis = Redis.new

get "/" do
    render "src/views/home.ecr"
end