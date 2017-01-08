require_relative 'spec_helper'
require_relative '../lib/1hdoc'

describe HDOC::Actions do
  include described_class

  before do
    @app = described_class
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

  context '#version' do
    it 'should output the program version' do
      expect { version }.to output(HDOC.version + "\n").to_stderr
    end
  end

  before do
    @repo_url = File.expand_path './tmp/test_repo'

    $stdin = StringIO.new(@repo_url)
    allow($stdout).to receive(:puts)
  end

  after { FileUtils.rm_rf @repo_url if File.directory? @repo_url }

  context '#init' do
    it 'should initialize a new configuration file' do
      init
      expect(File.exist?(@target_file)).to eq(true)
      expect(File.read(@target_file)).to include('day: 0')
    end

    it 'should clone the #100DaysOfCode repository' do
      init
      expect(File.directory?(@repo_url)).to eq(true)
    end
  end

  context '#commit' do
    before { $stdin = StringIO.new("#{@repo_url}\n1\n2\n3\n") }

    it 'should add a commit to the repository' do
      init
      commit

      expect(Git.open(@repo_url).log.first.message).to eq('Add Day 1')
    end

    it 'should stop user to commit if a record already exist' do
      init
      commit

      expect { commit }.to output("You are done for today :)\n").to_stderr
    end
  end
end
