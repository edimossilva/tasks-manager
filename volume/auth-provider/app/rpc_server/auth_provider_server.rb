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
    lambda do |_delivery_info, properties, payload|
      result = DoLoginService.new.call(payload)
      exchange.publish(
        result.to_s,
        routing_key: properties.reply_to,
        correlation_id: properties.correlation_id,
        headers: { status_code: 200 }
      )
    end
  end
end
