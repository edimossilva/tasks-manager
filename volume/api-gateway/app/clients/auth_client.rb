require 'singleton'
require_relative 'base_client.rb'

class AuthClient < BaseClient
  include Singleton
  attr_accessor :call_id, :response, :reply_queue,
                :server_queue_name, :reply_queue_name

  def initialize
    super
    @server_queue_name = 'rpc_login_request'
    @reply_queue_name = 'rpc_login_response'
  end

  def call(data)
    setup_reply_queue
    exchange.publish(data,
                     routing_key: server_queue_name,
                     correlation_id: correlation_id,
                     reply_to: reply_queue.name)

    lock_thread
    rpc_response
  end

  private

  def setup_reply_queue
    @reply_queue = channel.queue(@reply_queue_name, exclusive: false)

    reply_queue.subscribe do |_delivery_info, properties, payload|
      if self_reference.same_correlation_id?(properties)
        self_reference.response = format_response(properties, payload)

        self_reference.release_thread
      end
    end
  end
end
