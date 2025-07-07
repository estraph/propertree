# frozen_string_literal: true

require "logger"
require "propertree/version"

module Propertree
  LOG = Logger.new($stdout, level: Logger::DEBUG, formatter: proc { |severity, datetime, _progname, msg|
    "#{datetime} #{severity.rjust(5)}: #{msg}\n"
  })
end
