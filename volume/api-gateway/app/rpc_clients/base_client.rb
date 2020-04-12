class BaseClient
  attr_accessor :connection, :channel, :exchange,
                :lock, :condition, :response

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

  def lock_thread_or_timeout
    timeout = 1
    lock.synchronize { condition.wait(lock, timeout) }
  end

  def release_thread
    lock.synchronize { self_reference.condition.signal }
  end

  def subscribe(handle_response)
    sub_queue = channel.queue(sub_queue_name)
    sub_queue.subscribe(&handle_response)
  end

  def self_reference
    self
  end

  def stop
    channel.close
  end

  def publish(data)
    exchange.publish(data,
                     routing_key: pub_queue_name,
                     correlation_id: correlation_id,
                     reply_to: sub_queue_name)
  end

  def timeout_response
    {
      headers: { "status_code": 408 },
      data: { "error_message": 'timeout :(' }.to_json
    }
  end
end
