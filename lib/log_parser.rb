require 'pathname'
require_relative '../lib/log_aggregator'

class LogParser
  attr_reader :log_path

  def initialize(log_path)
    @log_path = log_path
    abort("Log: '#{log_path}' does not exist.") unless File.exist? log_path
  end

  def parse
    log_aggregator = LogAggregator.new
    File.open(log_path, 'r').each do |line|
      entry, ip = line.strip.split(' ')
      log_aggregator.add_log(entry, ip)
    end
    log_aggregator
  end
end
