class RedisCli
  include Singleton

  attr_reader :redis

  def initialize
    @redis = Redis.new(host: 'redis', port: 6379)
  end

  def find(key)
    redis.get(key)
  end

  def cache_user(response_dto)
    token = response_dto.data['token']
    redis.set(token, response_dto.response.to_json)
    response_dto
  end

  def find_cached_user(params)
    token = JSON.parse(params)['token']
    token_data = redis.get(token)
    return JSON.parse(token_data) if token_data
  end
end
