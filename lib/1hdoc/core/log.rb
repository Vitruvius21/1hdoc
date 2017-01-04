module HDOC
  ##
  # Provides methods for interact with the log file.
  class Log
    attr_reader :log_path

    def self.reset(log_path)
      log_path = File.expand_path(log_path)
      File.open(log_path, 'w') { |log| log.print '' }
    end

    def initialize(log_path)
      @log_path = File.expand_path(log_path)
      raise Errno::ENOENT unless File.exist? log_path
    end

    def append(content)
      File.open(log_path, 'a') { |log| log.puts content }
    end
  end
end
