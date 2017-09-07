class LogGroup < SimpleDelegator
  def print
    raise "Abstract method #{__method__} called"
  end
end

class ViewsLogGroup < LogGroup
  def print
    __getobj__.each do |aggregate_log_entry|
      puts "#{aggregate_log_entry.entry} #{aggregate_log_entry.views} visits"
    end
  end
end

class UniqueViewsLogGroup < LogGroup
  def print
    __getobj__.each do |aggregate_log_entry|
      puts "#{aggregate_log_entry.entry} #{aggregate_log_entry.views} unique views"
    end
  end
end
