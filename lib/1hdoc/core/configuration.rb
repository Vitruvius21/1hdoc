module HDOC
  ##
  # Provides methods for read configuration options by a file.
  # By default, it uses YAML as configuration file's parser.
  class Configuration
    attr_reader :options, :file_path

    ##
    # Initializes a new configuration file with a set of defaults options:
    #
    # ```
    # # Using a custom format
    # Configuration.init('~/package.json', JSON, name: 'howsweather', version: '0.1.4')
    #
    # # Using default format
    # Configuration.init('~/.1hdoc.yml', day: 0, last_commit_on: Time.now)
    # ```
    def self.init(file_path, file_parser = YAML, **options)
      file_path = File.expand_path(file_path)
      dumped_options = file_parser.dump(options)

      File.open(file_path, 'w') { |config| config.puts(dumped_options) }
    end

    def initialize(file_path, file_parser = YAML)
      @file_path = File.expand_path(file_path)
      @file_parser = file_parser
      @options = load_options
    end

    def load_options
      raise "Unable to find #{file_path}" unless File.exist? file_path
      @file_parser.load(File.read(file_path))
    end

    ##
    # Updates configuration file by rewriting the whole file using
    # init's singleton method.
    #
    # You should avoid this method for big files and use it for small ones.
    def update
      self.class.init(@file_path, @file_parser, options)
    end

    ##
    # Sets a new option or a edit an existing one.
    #
    # It's used in pair with Configuration#update in order to update
    # an existing configuration file.
    def set(option, value)
      @options[option] = value
    end
  end
end
