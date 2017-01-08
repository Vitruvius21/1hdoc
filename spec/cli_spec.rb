require_relative 'spec_helper'
require_relative '../lib/1hdoc'

describe HDOC::CLI do
  before do
    @app = described_class.new
    @target_file = File.expand_path described_class::ENVIRONMENT[:configuration_file]

    make_backup(@target_file) if File.exist? @target_file
  end

  after do
    if backup?(@target_file)
      File.write(@target_file, File.read(@target_file + '-backup'))
      File.delete(@target_file + '-backup')
    else
      File.delete(@target_file) if File.exist? @target_file
    end
  end

  it 'should execute the right command' do
    ARGV[0] = '-v'
    expect { @app.run }.to output(HDOC.version + "\n").to_stderr
  end

  it 'should return a list of available commands' do
    ARGV[0] = '-x24'
    expect { @app.run }.to output(/Usage: 1hdoc/).to_stderr
  end
end
