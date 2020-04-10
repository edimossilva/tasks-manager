require 'bunny'

class AuthProviderServer
  include Singleton
  attr_reader :channel, :exchange, :queue, :connection

  def initialize
    @connection = Bunny.new(ENV['CLOUDAMQP_URL'])
    @connection.start
    @channel = @connection.create_channel
  end

  def start(queue_name)
    @queue = channel.queue(queue_name)
    @exchange = channel.default_exchange
    subscribe_to_queue
  end

  def stop
    channel.close
    connection.close
  end

  def subscribe_to_queue
    queue.subscribe do |_delivery_info, properties, _payload|
      result = 'login result'
      exchange.publish(
        result.to_s,
        routing_key: properties.reply_to,
        correlation_id: properties.correlation_id
      )
    end
  end
end
