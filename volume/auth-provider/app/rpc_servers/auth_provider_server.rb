require 'bunny'

class AuthProviderServer < BaseServer
  include Singleton
  attr_reader :sub_queue_name

  def initialize
    super
    @sub_queue_name = 'rpc_login_request'
  end

  def start
    subscribe(handle_response)
  end

  private

  def handle_response
    lambda do |_delivery_info, properties, request_payload|
      result = DoLoginService.new.call(request_payload)
      publish(
        payload: result[:payload].to_json,
        routing_key: properties.reply_to,
        correlation_id: properties.correlation_id,
        headers: result[:headers]
      )
    end
  end
end
