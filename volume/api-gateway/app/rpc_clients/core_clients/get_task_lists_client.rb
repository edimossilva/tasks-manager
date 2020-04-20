require 'singleton'

module CoreClients
  class GetTaskListsClient < RabbitmqPubSub::RpcPublisher
    include Singleton

    def initialize
      @pub_queue_name = 'rpc_TMC_get_task_lists_request'
      @sub_queue_name = 'rpc_TMC_get_task_lists_response'
      super
    end
  end
end
