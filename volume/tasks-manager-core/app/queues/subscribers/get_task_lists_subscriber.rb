module Subscribers
  class GetTaskListsSubscriber < BaseSubscriber
    include Singleton
    attr_reader :sub_queue_name

    def initialize
      super
      @sub_queue_name = 'rpc_get_task_lists_request'
    end

    private

    def handle_response
      lambda do |_delivery_info, properties, request_payload|
        result = GetTaskListsService.new.call(request_payload)
        publish(
          payload: result[:payload].to_json,
          routing_key: properties.reply_to,
          correlation_id: properties.correlation_id,
          headers: result[:headers]
        )
      end
    end
  end
end
