require_relative 'spec_helper'
require_relative '../lib/1hdoc'

describe HDOC::Application do
  before do
    @app = described_class
    @target_file = File.expand_path '~/.1hdoc.yml'

    make_backup(@target_file) if File.exist? @target_file
  end

  after do
    if backup?(@target_file)
      File.write(@target_file, File.read(@target_file + '-backup'))
      File.delete(@target_file + '-backup')
    else
      File.delete(@target_file)
    end
  end

  context '#version' do
    it 'should output the program version' do
      expect { @app.version }.to output(HDOC.version + "\n").to_stderr
    end
  end


  context '#init' do
    it 'should initialize a new configuration file' do
      @app.init
      expect(File.exist?(@target_file)).to eq(true)
      expect(File.read(@target_file)).to include('day: 0')
    end
  end
end
