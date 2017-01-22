require 'fileutils'
require_relative 'spec_helper'
require_relative '../lib/1hdoc'

describe HDOC::Actions do
  include described_class

  before do
    @app = described_class
    @target_file = File.expand_path described_class::ENVIRONMENT[:configuration_file]

    make_backup(@target_file) if File.exist? @target_file
    File.write(@target_file, '')
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
      expect { version }.to output(HDOC.version + "\n").to_stderr
    end
  end

  before do
    @repo_url = File.expand_path './tmp/test_repo'

    $stdin = StringIO.new("n\n" + @repo_url)
    $stdout = File.open('.tmp_output', 'w')

    allow(Readline).to receive(:readline)
    allow($stderr).to receive(:puts)
  end

  after do
    FileUtils.rm_rf @repo_url if File.directory? @repo_url
    File.delete('.tmp_output')

    $stdout = STDOUT
  end

  context '#init' do
    before { init }

    it 'should initialize a new configuration file' do
      expect(File.read(@target_file)).to include('day: 0')
    end

    it 'should clone the #100DaysOfCode repository' do
      expect(File.directory?(@repo_url)).to eq(true)
    end
  end

  context '#commit' do
    before do
      init
      commit
    end

    it 'should add a commit to the repository' do
      expect(Git.open(@repo_url).log.first.message).to eq('Add Day 1')
    end

    it 'should stop user to commit if a record already exist' do
      expect { commit }.to output("You are done for today :)\n").to_stderr
    end
  end
end
