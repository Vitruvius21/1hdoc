module HDOC
  module Actions
    ##
    # Push the progress to the repository.
    def push
      open_repository
      @repository.push
    end
  end
end
