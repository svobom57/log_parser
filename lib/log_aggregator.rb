require_relative '../lib/log_group'

class LogAggregator
  LogEntry = Struct.new(:entry, :ip)
  AggregateLogEntry = Struct.new(:entry, :views)
  private_constant :LogEntry, :AggregateLogEntry

  attr_reader :log_entries

  def initialize
    @log_entries = Hash.new { |hash, key| hash[key] = [] }
  end

  def add_log(url_path, ip)
    log_entries[url_path] << LogEntry.new(url_path, ip)
  end

  def group_by_views
    grouped = log_entries.map { |url_path, log_entries| AggregateLogEntry.new(url_path, log_entries.length) }
    sorted = sort_by_views(grouped)

    ViewsLogGroup.new(sorted)
  end

  def group_by_unique_views
    grouped = log_entries.map do |url_path, log_entries|
      views = log_entries.uniq(&:ip).length
      AggregateLogEntry.new(url_path, views)
    end
    sorted = sort_by_views(grouped)

    UniqueViewsLogGroup.new(sorted)
  end

  private

  def sort_by_views(group)
    group.sort_by { |aggregate_log_entry| -aggregate_log_entry.views }
  end
end
