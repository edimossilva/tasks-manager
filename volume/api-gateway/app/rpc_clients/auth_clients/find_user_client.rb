require 'singleton'
require_relative '../rpc_client.rb'

module AuthClients
  class FindUserClient < RpcClient
    include Singleton

    def initialize
      @pub_queue_name = 'rpc_find_user_request'
      @sub_queue_name = 'rpc_find_user_response'
      super
    end
  end
end
