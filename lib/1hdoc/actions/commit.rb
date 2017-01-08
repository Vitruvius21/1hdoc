module HDOC
  module Actions
    ##
    # Register the daily progress.
    def self.commit
      @configuration = Configuration.new(ENVIRONMENT[:configuration_file])
      return $stderr.puts 'You are done for today :)' if record_already_exist?

      register_daily_progress
      commit_daily_progress
      update_last_record_day
    end

    private

    def self.record_already_exist?
      @configuration.options[:last_commit_on] == Time.now.strftime('%Y-%m-%d')
    end

    def self.register_daily_progress
      options = @configuration.options

      log = Log.new(File.join(options[:workspace], ENVIRONMENT[:log_file]))
      progress = Progress.new(options[:day] + 1)

      progress.register
      log.append(progress.format)
    end

    def self.commit_daily_progress
      options = @configuration.options

      repository = Repository.new(options[:workspace])
      repository.commit("Add Day #{options[:day] + 1}")

      push if options[:auto_push]
    end

    def self.update_last_record_day
      @configuration.set :day, @configuration.options[:day] + 1
      @configuration.set :last_commit_on, Time.now.strftime('%Y-%m-%d')

      @configuration.update
    end
  end
end
