require 'singleton'

class AmqpConnection
  include Singleton

  attr_accessor :connection

  def initialize
    @connection = Bunny.new(ENV['CLOUDAMQP_URL'], automatically_recover: true)
    @connection.start
  end
end
