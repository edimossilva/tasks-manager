class BaseServer
  attr_accessor :connection, :channel, :exchange

  def initialize
    @connection = AmqpConnection.instance.connection
    @channel = connection.create_channel
    @exchange = channel.default_exchange
  end

  def stop
    channel.close
  end

  def subscribe(handle_response)
    sub_queue = channel.queue(sub_queue_name)
    sub_queue.subscribe(&handle_response)
  end

  def publish(payload:, routing_key:, correlation_id:, headers:)
    validate_payload!(payload)
    validate_headers!(headers)

    exchange.publish(
      payload,
      routing_key: routing_key,
      correlation_id: correlation_id,
      headers: headers
    )
  end

  def validate_payload!(payload)
    if payload.blank? ||
       payload.nil? ||
       !payload.is_a?(String)
      raise StandardError, "Invalid payload value:#{payload}"
    end

    true
  end

  def validate_headers!(headers)
    if headers.blank? ||
       headers.nil? ||
       !headers.key?(:status_code)
      raise StandardError, "Invalid headers value:#{headers}"
    end

    true
  end
end
