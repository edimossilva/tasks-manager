class AuthProviderSubscriber < RabbitmqPubSub::BaseSubscriber
  include Singleton
  attr_reader :sub_queue_name

  def initialize
    super
    @sub_queue_name = 'rpc_login_request'
  end

  private

  def action(request_payload)
    DoLoginService.new.call(request_payload)
  end
end
