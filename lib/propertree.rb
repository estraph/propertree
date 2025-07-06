# frozen_string_literal: true

require_relative "propertree/version"
require "logger"

module Propertree
  LOG = Logger.new($stdout, level: Logger::DEBUG, formatter: proc { |severity, datetime, _progname, msg|
    "#{datetime} #{severity.rjust(5)}: #{msg}\n"
  })

  class Error < StandardError; end
end
