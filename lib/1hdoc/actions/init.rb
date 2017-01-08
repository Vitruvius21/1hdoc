module HDOC
  module Actions
    ##
    # Initialize the necessary files cloning the #100DaysOfCode's repo
    # and create the configuration file in the user's $HOME path.
    def self.init
      puts 'Where I should locate the #100DaysOfCode repo (ex. ~/my_repo): '
      @workspace = File.expand_path $stdin.gets.chomp

      Repository.clone(ENVIRONMENT[:repository_url], @workspace)
      Log.reset(File.join(@workspace, ENVIRONMENT[:log_file]))

      initialize_configuration_file
      puts 'Here we are! You are ready to go.'
    end

    private

    def self.initialize_configuration_file
      defaults = { auto_push: false, day: 0, workspace: @workspace }
      Configuration.init(ENVIRONMENT[:configuration_file], defaults)
    end
  end
end
