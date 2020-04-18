module Subscribers
  class CreateTaskListSubscriber < BaseSubscriber
    include Singleton
    attr_reader :sub_queue_name

    def initialize
      super
      @sub_queue_name = 'rpc_create_task_list_request'
    end

    private

    def handle_response
      lambda do |_delivery_info, properties, request_payload|
        CreateTaskListService.new.call(request_payload)
        result = {
          payload: 'mockresult',
          headers: { status_code: '202' }
        }
        # binding.pry
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
