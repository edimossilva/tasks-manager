module Subscribers::Tasklist
  class GetTaskListsSubscriber < Subscribers::BaseSubscriber
    include Singleton

    def initialize
      super
      @sub_queue_name = 'rpc_get_task_lists_request'
    end

    private

    def action(request_payload)
      GetTaskListsService.new.call(request_payload)
    end
  end
end
