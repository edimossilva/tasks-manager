ENV['SINATRA_ENV'] ||= 'development'
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'pry'
require 'bunny'
require 'securerandom'

Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'
