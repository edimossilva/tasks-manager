require 'sinatra'
require 'sinatra/reloader'

require './clients/auth_client'
set :bind, '0.0.0.0'

get '/' do
  puts 'oi'
  result = AuthClient.instance.call('edimo')
  puts 'thau'
  result
end
