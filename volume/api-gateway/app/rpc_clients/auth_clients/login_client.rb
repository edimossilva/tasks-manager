require 'singleton'

module AuthClients
  class LoginClient < RabbitmqPubSub::RpcPublisher
    include Singleton

    def initialize
      @pub_queue_name = 'rpc_login_request'
      @sub_queue_name = 'rpc_login_response'
      super
    end
  end
end
