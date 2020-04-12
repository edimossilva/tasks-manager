class BaseClient
  attr_accessor :connection, :channel, :exchange, :lock, :condition

  def initialize
    @connection = AmqpConnection.instance.connection
    @channel = connection.create_channel
    @exchange = channel.default_exchange

    @lock = Mutex.new
    @condition = ConditionVariable.new
  end

  protected

  def correlation_id
    @correlation_id = SecureRandom.hex if @correlation_id.nil?
    @correlation_id
  end

  def format_response(properties, payload)
    {
      headers: properties[:headers],
      data: payload
    }
  end

  def lock_thread
    timeout = 1
    lock.synchronize { condition.wait(lock, timeout) }
  end

  def release_thread
    lock.synchronize { self_reference.condition.signal }
  end

  def rpc_response
    response || timeout_response
  end

  def same_correlation_id?(properties)
    properties[:correlation_id] == correlation_id
  end

  def self_reference
    self
  end

  def stop
    channel.close
  end

  def timeout_response
    {
      headers: { "status_code": 408 },
      data: { "error_message": 'timeout :(' }.to_json
    }
  end
end
