module HDOC
  ##
  # Provides methods for read configuration options by a file.
  # By default, it uses YAML as configuration file's parser.
  class Configuration
    attr_reader :options, :file_path

    def self.init(file_path, file_parser = YAML, **options)
      file_path = File.expand_path(file_path)

      File.open(file_path, 'w') do |configuration_file|
        configuration_file.puts file_parser.dump(options)
      end
    end

    def initialize(file_path, file_parser = YAML)
      @file_path = File.expand_path(file_path)
      @file_parser = file_parser
      @options = {}

      raise "Unable to find #{@file_path}" unless File.exist? @file_path
      load_options
    end

    def load_options
      @options = @file_parser.load(File.read(file_path))
    end

    def update
      Configuration.init(@file_path, @file_parser, options)
    end

    def set(option, value)
      @options[option] = value
    end
  end
end
