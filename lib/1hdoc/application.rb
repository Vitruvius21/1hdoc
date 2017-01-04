module HDOC
  ##
  # Implements a bridge between the CLI and the core classes
  # providing methods for talk with this ones.
  module Application
    ENVIRONMENT = {
      configuration_file: File.expand_path('~/.1hdoc.yml'),
      repository_url: 'https://github.com/Kallaway/100-days-of-code'
    }.freeze

    DEFAULTS = {
      auto_push: true,
      day: 0,
      last_commit_on: ''
    }.freeze

    ##
    # Initialize the necessary files cloning the #100DaysOfCode's repo
    # and create the configuration file in the user's $HOME path.
    def self.init
      Configuration.init(ENVIRONMENT[:configuration_file], DEFAULTS)
    end

    def self.version
      $stderr.puts HDOC.version
    end
  end
end
