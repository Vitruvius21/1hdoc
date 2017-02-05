module HDOC
  module Actions
    ##
    # Push the progress to the repository.
    def push
      if user_already_pushed?
        $stderr.puts 'You already pushed for today'
        return
      end

      open_repository
      @repository.push
    end

    private

    def user_already_pushed?
      config = Configuration.new(ENVIRONMENT[:configuration_file])
      config.options[:last_commit_on] == Time.now.strftime('%Y-%m-%d')
    end
  end
end
