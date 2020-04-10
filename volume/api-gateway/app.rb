require 'sinatra'
require 'sinatra/reloader'

puts 'uppppp'
set :bind, '0.0.0.0'

get '/' do
  'Hello world!'
end

get '/edimo' do
  'Hello world!'
end
