module HDOC
  module Actions
    ##
    # Push the progress to the repository.
    def push
      option_repository
      @repository.push
    end
  end
end
