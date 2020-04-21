class RedisConnection
  include Singleton

  attr_reader :redis

  def initialize
    @redis = Redis.new(host: 'redis', port: 6379)
  end

  def store(key, value)
    redis.set(key, value)
  end

  def find(key)
    redis.get(key)
  end
end
