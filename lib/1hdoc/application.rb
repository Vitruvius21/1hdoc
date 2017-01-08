module HDOC
  ##
  # Implements a bridge between the CLI and the core classes
  # providing methods for talk with this ones.
  module Application
    ENVIRONMENT = {
      configuration_file: File.expand_path('~/.1hdoc.yml'),
      repository_url: 'https://github.com/Kallaway/100-days-of-code',
      log_file: 'log.md'
    }.freeze

    @defaults = {
      auto_push: false,
      day: 0,
      last_commit_on: ''
    }

    ##
    # Initialize the necessary files cloning the #100DaysOfCode's repo
    # and create the configuration file in the user's $HOME path.
    def self.init
      puts 'Where I should locate the #100DaysOfCode repo (ex. ~/my_repo): '
      @defaults[:workspace] = File.expand_path $stdin.gets.chomp

      Repository.clone(ENVIRONMENT[:repository_url], @defaults[:workspace])
      Configuration.init(ENVIRONMENT[:configuration_file], @defaults)
      Log.reset(File.join(@defaults[:workspace], ENVIRONMENT[:log_file]))

      puts 'Here we are! You are ready to go.'
    end

    ##
    # Push the progress to the repository.
    def self.push
      options = Configuration.new(ENVIRONMENT[:configuration_file]).options
      repository = Repository.new(options[:workspace])

      repository.push
    end

    def self.version
      $stderr.puts HDOC.version
    end

    ##
    # Register the daily progress.
    def self.commit
      @configuration = Configuration.new(ENVIRONMENT[:configuration_file])
      return $stderr.puts 'You are done for today :)' if record_already_exist?

      register_daily_progress
      commit_daily_progress
      update_last_record_day
    end

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
