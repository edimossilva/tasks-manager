ENV['SINATRA_ENV'] ||= 'development'
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'pry'
require 'bunny'
require 'securerandom'
require 'rabbitmq_pub_sub'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'
