require_relative 'spec_helper'
require_relative '../lib/1hdoc/core/configuration'

describe HDOC::Configuration do
  before { @target_file = File.expand_path './example_config.yml' }
  after  { File.delete @target_file if File.exist? @target_file }

  it 'should raise an error if the given file is not found' do
    expect { described_class.new('~/.123x.yml') }.to raise_error(Errno::ENOENT)
  end

  it 'should accept a custom file parser' do
    described_class.init(@target_file, JSON, it_works: true)
    configuration = described_class.new(@target_file, JSON)

    expect(configuration.options['it_works']).to eq(true)
  end

  context '.init' do
    it 'should initialize a new configuration file' do
      described_class.init(@target_file)
      expect(File.exist?(@target_file)).to eq(true)
    end

    it 'should write the given options on the configuration file' do
      described_class.init(@target_file, it_works: true)
      expect(File.read(@target_file)).to include('it_works')
    end
  end
end
