require 'singleton'
require_relative '../rpc_client.rb'

module CoreClients
  class GetTaskListsClient < RpcClient
    include Singleton

    def initialize
      @pub_queue_name = 'rpc_get_task_lists_request'
      @sub_queue_name = 'rpc_get_task_lists_response'
      super
    end
  end
end
