require 'singleton'

module CoreClients
  class CreateTaskListClient < RabbitmqPubSub::RpcPublisher
    include Singleton

    def initialize
      @pub_queue_name = 'rpc_create_task_list_request'
      @sub_queue_name = 'rpc_create_task_list_response'
      super
    end
  end
end
