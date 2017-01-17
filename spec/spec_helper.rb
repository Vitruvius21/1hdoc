require 'rspec'
require 'yaml'
require 'json'
require 'git'
require 'fileutils'
require 'codacy-coverage'
require 'readline'

Codacy::Reporter.start

RSpec.configure do
  $PROGRAM_NAME = __FILE__

  # Backup a file if it exists creating a copy with the `-backup` prefix.
  def make_backup(filename)
    File.open(filename + '-backup', 'w') do |backup_file|
      backup_file.puts File.read(filename)
    end
  end

  def backup?(filename)
    File.exist? filename + '-backup'
  end
end
