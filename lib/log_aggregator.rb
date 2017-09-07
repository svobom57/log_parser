require_relative '../lib/log_group'

class LogAggregator
  LogEntry = Struct.new(:entry, :ip)
  AggregateLogEntry = Struct.new(:url_path, :views) do
    def <=>(other)
      result = (other.views <=> views)
      return result unless result.zero?
      url_path <=> other.url_path
    end
  end

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
    group.sort { |log1, log2| log1 <=> log2 }
  end
end
