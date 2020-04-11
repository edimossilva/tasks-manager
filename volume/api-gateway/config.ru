require 'sinatra'

require_relative './config/environment'

set :bind, '0.0.0.0'
set :server, :thin

use ApplicationController
run AuthenticationController
