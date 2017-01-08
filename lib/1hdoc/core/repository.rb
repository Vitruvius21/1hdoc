module HDOC
  ##
  # Provides an interface for interact with Git repositories.
  class Repository
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

    rescue @adapter::GitExecuteError => error
      $stderr.puts error
    end

    def push
      puts @repo.push
    rescue @adapter::GitExecuteError => error
      $stderr.puts error
    end
  end
end
