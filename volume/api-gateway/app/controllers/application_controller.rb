class ApplicationController < Sinatra::Base
  attr_reader :body_params

  before do
    request.body.rewind
    @body_params = JSON.parse request.body.read
  end

  get '/' do
    data = { username: 'registered_user1',
             password: '111' }
    result = AuthClient.instance.call(data.to_json)
    result
  end
end
