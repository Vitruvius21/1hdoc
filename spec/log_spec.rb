require_relative 'spec_helper'
require_relative '../lib/1hdoc/core/log'

describe HDOC::Log do
  ##
  # Initialize all necessary files used to test this class.
  before do
    @example_log = File.expand_path('./example_log.md')
    File.write(@example_log, '')

    @log = described_class.new(@example_log)
  end

  after { File.delete(@example_log) }

  it 'should raise an error if the log is not found' do
    expect { described_class.new('./è2') }.to raise_error(Errno::ENOENT)
  end

  context '#append' do
    it 'should append the given string to the log' do
      @log.append('I appended!')
      expect(File.read(@example_log)).to eq("I appended!\n")
    end

    it "shouldn't override existing content" do
      @log.append('I appended!')
      @log.append('Me too.')

      expect(File.read(@example_log)).to include('I appended!')
    end
  end

  context '.reset' do
    before { @target_file = File.expand_path('./example_log_2.md') }
    after  { File.delete(@target_file) }

    it 'should create the file if it not exists' do
      described_class.reset(@target_file)
      expect(File.exist?(@target_file)).to eq(true)
    end

    it 'should delete everything stored in the file' do
      File.write(@target_file, 'You should not read me.')

      described_class.reset(@target_file)
      expect(File.read(@target_file)).to eq('')
    end
  end
end
