module HDOC
  ##
  # Provides the CLI interface for interact with the program.
  class CLI
    attr_reader :options
    include Actions

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
      start_option_parser
    rescue @option_parser::ParseError
      $stderr.puts options
    end

    private

    def check_for_configuration
      unless File.exist? ENVIRONMENT[:configuration_file]
        $stderr.puts 'Seems like it is the first time you use 1hdoc..'
        init
      end
    end

    def start_option_parser
      @option_parser.new do |opts|
        opts.banner = 'Usage: 1hdoc [options]'

        @options = opts
        initialize_options
      end.parse!
    end

    def initialize_options
      AVAILABLE_COMMANDS.each do |command|
        # Retrieve method's name deleting double dashes from command.
        target_method = command[1].gsub('--', '')
        options.on(*command) { send(target_method) }
      end
    end
  end
end
