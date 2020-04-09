require 'bunny'
require 'singleton'

module Producers
  class Connection
    include Singleton

    attr_reader :connection

    def initialize
      @connection = Bunny.new(ENV['CLOUDAMQP_URL'])
      @connection.start
    rescue Bunny::TCPConnectionFailedForAllHosts => e
      Rails.logger.error e.message
      Rails.logger.info e.backtrace.join "\n"
    end

    def create_channel
      return connection.create_channel if connection.status == :open

      raise Bunny::TCPConnectionFailed, 'Connection not created'
    end

    def close_connection
      connection.close
    end
  end
end
