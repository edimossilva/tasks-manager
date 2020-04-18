require 'singleton'

module Producers
  class TaskCreatedProducer
    include Singleton
    attr_reader :channel, :queue

    def initialize
      @channel = AmqpConnection.instance.create_channel
      @queue = channel.queue('task_created_queue')
    rescue Bunny::Exception => e
      Rails.logger.error e.message
      Rails.logger.info e.backtrace.join "\n"
    end

    def publish(message)
      channel&.default_exchange&.publish(message, routing_key: queue.name)
    rescue Bunny::Exception => e
      Rails.logger.error e.message
      Rails.logger.info e.backtrace.join "\n"
    end
  end
end
