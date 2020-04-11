require 'sinatra'
require 'sinatra/reloader'

require './clients/auth_client'
set :bind, '0.0.0.0'

get '/' do
  data = { username: 'registered_user1',
           password: '111' }
  result = AuthClient.instance.call(data.to_json)
  result
end
