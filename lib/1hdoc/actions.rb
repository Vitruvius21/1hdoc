module HDOC
  ##
  # Implements actions which can be executed by the program.
  module Actions
    ENVIRONMENT = {
      configuration_file: File.expand_path('~/.1hdoc.yml'),
      repository_url: 'https://github.com/Kallaway/100-days-of-code',
      log_file: 'log.md'
    }.freeze
  end
end

require_relative 'actions/push'
require_relative 'actions/commit'
require_relative 'actions/init'
require_relative 'actions/version'
