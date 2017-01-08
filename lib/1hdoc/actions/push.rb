module HDOC
  module Actions
    ##
    # Push the progress to the repository.
    def self.push
      options = Configuration.new(ENVIRONMENT[:configuration_file]).options
      repository = Repository.new(options[:workspace])

      repository.push
    end
  end
end
