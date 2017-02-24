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
      $stderr.puts 'Finish your answer by typing :!'

      QUESTIONS.each do |field, question|
        $stderr.puts question
        @record[field] = ''

        while text_line = Readline.readline
          @record[field] << text_line.sub(':!', '')
          break if text_line[':!']
        end
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
  end
end
