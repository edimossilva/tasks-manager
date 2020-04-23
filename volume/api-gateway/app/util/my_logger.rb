class MyLogger
  include Singleton

  attr_reader :logger

  def initialize
    @logger = Logger.new STDOUT
  end

  def self.info(data)
    MyLogger.instance.logger.info(data)
  end

  def self.error(data)
    MyLogger.instance.logger.error(data)
  end
end
