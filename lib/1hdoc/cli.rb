module HDOC
  ##
  # Provides the CLI interface for interact with the program.
  class CLI
    AVAILABLE_COMMANDS = [
      ['-i', '--init', 'Initialize necessary files.'],
      ['-c', '--commit', 'Register your progress and sync it.'],
      ['-p', '--push', 'Manually synchronize your online repository.'],
      ['-v', '--version', 'Show program version.']
    ].freeze

    def initialize(option_parser = OptionParser)
      @option_parser = option_parser
      check_for_configuration
    end

    def run
      @option_parser.new do |opts|
        opts.banner = 'Usage: 1hdoc [options]'

        @options = opts
        initialize_options
      end.parse!

    rescue @option_parser::ParseError
      $stderr.puts @options
    end

    private

    def check_for_configuration
      unless File.exist? Actions::ENVIRONMENT[:configuration_file]
        $stderr.puts 'Unable to find configuration file..'
        Actions.init
      end
    end

    def initialize_options
      AVAILABLE_COMMANDS.each do |command|
        @options.on(*command) { Actions.send(remove_dashes(command[1])) }
      end
    end

    def remove_dashes(command)
      command.sub('--', '')
    end
  end
end
