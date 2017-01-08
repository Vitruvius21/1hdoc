module HDOC
  ##
  # Implements actions which can be executed by the program.
  module Actions
    ENVIRONMENT = {
      configuration_file: File.expand_path('~/.1hdoc.yml'),
      repository_url: 'https://github.com/Kallaway/100-days-of-code',
      log_file: 'log.md'
    }.freeze

    private

    def open_configuration_file
      @configuration = Configuration.new(ENVIRONMENT[:configuration_file])
      @options = @configuration.options
    end

    def open_repository
      option_configuration_file unless @configuration
      @repository = Repository.new(@options[:workspace])
    end

    def open_log
      @log = Log.new(File.join(@options[:workspace], ENVIRONMENT[:log_file]))
    end
  end
end

require_relative 'actions/push'
require_relative 'actions/commit'
require_relative 'actions/init'
require_relative 'actions/version'
