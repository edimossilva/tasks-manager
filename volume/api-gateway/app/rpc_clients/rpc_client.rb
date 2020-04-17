require_relative 'base_client.rb'

class RpcClient < BaseClient
  attr_accessor :pub_queue_name, :sub_queue_name

  def initialize
    super
  end

  def call(data)
    subscribe(handle_response)

    publish(data)

    lock_thread_or_timeout

    response || timeout_response
  end

  private

  def handle_response
    lambda do |_delivery_info, properties, payload|
      if properties[:correlation_id] == correlation_id
        self_reference.response = format_response(properties, payload)

        self_reference.release_thread
      end
    end
  end
end
