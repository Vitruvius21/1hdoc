module HDOC
  ##
  # Provides methods for register and format user's daily progress.
  class Progress
    attr_accessor :record

    QUESTIONS = {
      progress: 'Your progress: ',
      thoughts: 'Your thoughts: ',
      link: 'Link to work: '
    }.freeze

    def initialize(current_day)
      @current_day = current_day
      @current_date = Time.now.strftime('%Y-%m-%d')

      @record = {}
    end

    def register
      QUESTIONS.each do |field, question|
        puts question
        @record[field] = gets.chomp
      end
    end

    def format
      result = "### Day #{@current_day}\n"
      record.each { |field, value| result << format_field(field, value) }

      result
    end

    def format_field(field, value)
      "**#{field.capitalize}:** #{value}\n\n"
    end
  end
end
