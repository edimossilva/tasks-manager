require 'singleton'

class AuthClient
  include Singleton
  attr_accessor :call_id, :response, :lock, :condition, :connection,
                :channel, :server_queue_name, :reply_queue, :exchange

  def initialize
    @connection = Bunny.new(ENV['CLOUDAMQP_URL'], automatically_recover: true)
    @connection.start

    @channel = connection.create_channel
    @exchange = channel.default_exchange
    @server_queue_name = 'rpc_login_request'

    setup_reply_queue
  end

  def call(data)
    @call_id = SecureRandom.hex
    exchange.publish(data,
                     routing_key: server_queue_name,
                     correlation_id: call_id,
                     reply_to: reply_queue.name)

    # wait for the signal or timeout to continue the execution
    timeout = 2
    # lock.synchronize { condition.wait(lock) }
    lock.synchronize { condition.wait(lock, timeout) }
    response || timeout_response
  end

  def stop
    channel.close
    connection.close
  end

  private

  def timeout_response
    {
      headers: { "status_code": 408 },
      data: { "error_message": 'timeout :(' }.to_json
    }
  end

  def setup_reply_queue
    @lock = Mutex.new
    @condition = ConditionVariable.new
    that = self
    @reply_queue = channel.queue('rpc_login_response', exclusive: false)

    reply_queue.subscribe do |_delivery_info, properties, payload|
      # binding.pry

      if properties[:correlation_id] == that.call_id
        that.response = {
          headers: properties[:headers],
          data: payload
        }

        # sends the signal to continue the execution of #call
        that.lock.synchronize { that.condition.signal }
      end
    end
  end
end
