module Producers
  module ProducersHelper
    def publish_task_created(payload)
      Producers::TaskCreatedProducer.instance.publish(payload)
    end
  end
end
