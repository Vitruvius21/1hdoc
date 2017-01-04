module HDOC
  ##
  # Provides methods for interact with the log file.
  class Log
    def self.reset(log_path)
      log_path = expand_path(log_path)
      File.open(log_path, 'w') { |log| log.print '' }
    end

    def initialize(log_path)
      @log_path = expand_path(log_path)
      raise Errno::ENOENT unless File.exist? log_path
    end

    def append(content)
      File.open(@log_path, 'a') { |log| log.puts content }
    end

    private

    def expand_path(path)
      File.expand_path(path, File.dirname($PROGRAM_NAME))
    end
  end
end
