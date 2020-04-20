require 'singleton'

module AuthClients
  class FindUserClient < RabbitmqPubSub::RpcPublisher
    include Singleton

    def initialize
      @pub_queue_name = 'rpc_AU_find_user_request'
      @sub_queue_name = 'rpc_AU_find_user_response'
      super
    end
  end
end
