require_relative 'spec_helper'
require_relative '../lib/1hdoc/core/repository'

describe HDOC::Repository do
  before do
    ENV['GIT_AUTHOR_NAME'] = 'test'
    ENV['GIT_AUTHOR_EMAIL'] = 'example@example.com'

    @repo_url = 'https://github.com/Kallaway/100-days-of-code'
    @repo_dest = File.expand_path './tmp/'
  end

  after { FileUtils.rm_rf @repo_dest if File.directory? @repo_dest }

  it 'should warn the user if no valid Git repo is found' do
    expect { described_class.new('./12eq') }.to output.to_stderr
  end

  context '.clone' do
    it 'should clone an existing repository' do
      described_class.clone(@repo_url, @repo_dest)
    end

    it 'should print an error if the URL is not valid' do
      expect { described_class.clone('dwmflm13', @repo_dest) }.to output.to_stderr
    end
  end

  context '#commit' do
    before do
      described_class.clone(@repo_url, @repo_dest)
      @repo = described_class.new(@repo_dest)
    end

    it 'should add a commit' do
      File.open(File.join(@repo_dest, 'log.md'), 'a') do |log|
        log.puts 'RSpec is running!'
      end

      @repo.commit('RSpec is running')
      expect(Git.open(@repo_dest).log.first.message).to eq('RSpec is running')
    end
  end
end
