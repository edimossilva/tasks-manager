class ApplicationController < Sinatra::Base
  attr_reader :body_params

  before do
    request.body.rewind
    request_body = request.body.read
    @body_params = if !request_body.empty?
                     JSON.parse request_body
                   else
                     {}
                   end
  end

  get '/' do
    data = { username: 'registered_user1',
             password: '111' }
    result = AuthClient.instance.call(data.to_json)
    result.to_s
  end

  protected

  def render_unprocessable_entity(params)
    status 415
    json({ data: params })
  end
end
