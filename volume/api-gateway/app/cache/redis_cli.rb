class RedisCli
  include Singleton

  attr_reader :redis

  def initialize
    @redis = Redis.new(host: 'redis', port: 6379)
  end

  def find(key)
    redis.get(key)
  end

  def cache_user(response)
    response_hash = JSON.parse(response[:data])
    token = response_hash['data']['token']
    redis.set(token, response.to_json)
    response
  end

  def find_cached_user(params)
    token = JSON.parse(params)['token']
    token_data = redis.get(token)
    return JSON.parse(token_data) if token_data
  end
end
