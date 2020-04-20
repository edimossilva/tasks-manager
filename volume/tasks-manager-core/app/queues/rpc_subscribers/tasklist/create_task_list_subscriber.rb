module RpcSubscribers::Tasklist
  class CreateTaskListSubscriber < RabbitmqPubSub::BaseSubscriber
    include Singleton

    def initialize
      super
      @sub_queue_name = 'rpc_TMC_create_task_list_request'
    end

    private

    def action(request_payload)
      CreateTaskListService.new.call(request_payload)
    end
  end
end
