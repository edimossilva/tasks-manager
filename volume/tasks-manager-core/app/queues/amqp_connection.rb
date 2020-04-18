require 'bunny'
require 'singleton'

class AmqpConnection
  include Singleton

  attr_reader :connection

  def initialize
    @connection = Bunny.new(ENV['CLOUDAMQP_URL'])
    @connection.start
  end

  def create_channel
    return connection.create_channel if connection.status == :open

    raise Bunny::TCPConnectionFailed, 'Connection not created'
  end

  def close_connection
    connection.close
  end
end
