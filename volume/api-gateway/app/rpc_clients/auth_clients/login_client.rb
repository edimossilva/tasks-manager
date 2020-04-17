require 'singleton'
require_relative '../rpc_client.rb'

module AuthClients
  class LoginClient < RpcClient
    include Singleton

    def initialize
      super
      @pub_queue_name = 'rpc_login_request'
      @sub_queue_name = 'rpc_login_response'
    end
  end
end
