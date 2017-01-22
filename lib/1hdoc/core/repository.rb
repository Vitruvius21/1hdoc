module HDOC
  ##
  # Provides an interface for interact with Git repositories.
  class Repository
    attr_reader :adapter

    def self.clone(url, destination, adapter = Git)
      adapter.clone(url, destination)
    rescue adapter::GitExecuteError => error
      $stderr.puts error.message
    end

    def initialize(repo_path, adapter = Git)
      @adapter = adapter
      @repo = @adapter.open(repo_path)
    rescue ArgumentError
      $stderr.puts 'The given repository is not a valid one.'
    end

    def commit(message)
      @repo.add(all: true)
      @repo.commit(message)
    end

    def push
      @repo.push
    rescue adapter::GitExecuteError => error
      $stderr.puts error.message
    end
  end
end
