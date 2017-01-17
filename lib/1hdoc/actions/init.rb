module HDOC
  module Actions
    QUESTIONS = {
      day: 'Great! On what day you are: ',
      workspace: 'Ok! Where I could find your workspace (ex. ~/work/100doc): '
    }.freeze

    ##
    # Initialize the necessary files cloning the #100DaysOfCode's repo
    # and create the configuration file in the user's $HOME path.
    def init
      print 'Do you already maintain a log on your PC? [yn] '
      already_active = gets.chomp.downcase

      return customize_configuration_file if already_active == 'y'

      puts 'Where I should locate the #100DaysOfCode repo (ex. ~/my_repo): '
      @workspace = File.expand_path $stdin.gets.chomp

      initialize_workspace
      initialize_configuration_file

      $stderr.puts 'Here we are! You are ready to go.'
    end

    private

    def customize_configuration_file
      configuration_options = {}

      QUESTIONS.each do |option, question|
        configuration_options[option] = Readline.readline(question, false)
      end

      initialize_configuration_file(configuration_options)
      $stderr.puts 'Here we are! You are ready to go.'
    end

    def initialize_workspace
      Repository.clone(ENVIRONMENT[:repository_url], @workspace)
      Log.reset(File.join(@workspace, ENVIRONMENT[:log_file]))
    end

    def initialize_configuration_file(options = {})
      defaults = {
        auto_push: false,
        day: 0,
        workspace: @workspace
      }.merge(options)

      Configuration.init(ENVIRONMENT[:configuration_file], defaults)
    end
  end
end
