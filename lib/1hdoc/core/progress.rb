module HDOC
  ##
  # Provides methods for register and format user's daily progress.
  class Progress
    attr_reader :record

    QUESTIONS = {
      progress: 'Your progress: ',
      thoughts: 'Your thoughts: ',
      link: 'Link to work: '
    }.freeze

    def initialize(current_day)
      @current_day = current_day
      @current_date = Time.now.strftime('%B %d, %Y')

      @record = {}
    end

    def register
      QUESTIONS.each do |field, question|
        @record[field] = Readline.readline(question, false)
      end
    end

    def format
      result = "### Day #{@current_day}: #{@current_date}\n"
      record.each { |field, value| result << format_field(field, value) }

      result
    end

    def format_field(field, value)
      "**#{field.capitalize}:** #{value}\n\n"
    end

    def set_record(record)
      @record = record
    end
  end
end
