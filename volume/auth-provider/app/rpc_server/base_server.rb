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
end
