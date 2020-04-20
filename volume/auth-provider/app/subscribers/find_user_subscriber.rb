class FindUserSubscriber < RabbitmqPubSub::BaseSubscriber
  include Singleton
  attr_reader :sub_queue_name

  def initialize
    super
    @sub_queue_name = 'rpc_AU_find_user_request'
  end

  private

  def action(request_payload)
    FindUserService.new.call(request_payload)
  end
end
