require 'rspec'
require 'yaml'
require 'git'
require 'readline'

begin
  require 'codacy-coverage'
  Codacy::Reporter.start
rescue LoadError => error
end

##
# Provides methods used across various specs.
module RSpecMixin
  def make_backup(filename)
    File.open(filename + '-backup', 'w') do |backup_file|
      backup_file.puts File.read(filename)
    end
  end

  def backup?(filename)
    File.exist? filename + '-backup'
  end
end

RSpec.configure do |config|
  $PROGRAM_NAME = __FILE__
  config.include RSpecMixin
end
