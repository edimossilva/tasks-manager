class MyLogger
  include Singleton

  COLOR_ESCAPES = {
    none: 0,
    bright: 1,
    black: 30,
    red: 31,
    green: 32,
    yellow: 33,
    blue: 34,
    magenta: 35,
    cyan: 36,
    white: 37,
    default: 39
  }.freeze

  attr_reader :logger

  def initialize
    @logger = Logger.new STDOUT
  end

  def self.info(data)
    MyLogger.instance.logger.info(c(:blue, data))
  end

  def self.error(data)
    MyLogger.instance.logger.error(c(:red, data))
  end

  def self.c(clr, text = nil)
    "\x1B[" + (COLOR_ESCAPES[clr] || 0).to_s + 'm' + (text ? text + "\x1B[0m" : '')
  end

  def self.bc(clr, text = nil)
    "\x1B[" + ((COLOR_ESCAPES[clr] || 0) + 10).to_s + 'm' + (text ? text + "\x1B[0m" : '')
  end
end
