class Quiz
  class Question
    attr_reader :text, :options, :number, :correct_answer

    def initialize(text:, correct_answer:, number: '', options: [])
      @text = text.sub(/[,!\.\?]$/, '') + '?'
      @number = number
      @correct_answer = correct_answer
      @options = []
      build_options_from_array_of_strings(options) if options.present? && options.is_a?(Array)
    end

    def to_s
      text
    end

    def add_option(input)
      @options << Quiz::Option.new(input)
    end

    def answered?
      @answered ||= options.reject { |option| !option.selected? }.count >= 1
    end

    def answered_correctly?
      @answered_correctly ||= options.reject { |option| !option.answered_correctly? }.count == 1
    end

    def answered_incorrectly?
      @answered_incorrectly ||= options.select { |option| option.answered_incorrectly?  }.count >= 1
    end

    def toggle_select_for_option(letter)
      options.select { |option| option.letter.downcase == letter.downcase }&.first&.toggle_select!
    end

    def to_json
      {
        text: text,
        number: number,
        correct_answer: correct_answer,
        options: options,
      }.to_json
    end

    private

    # "None of the above." is the correct answer if the list of options does not have the correct answer

    def build_options_from_array_of_strings(selection)
      selection.each_with_index do |option, index|
        none_is_correct_answer =  (option == I18n.t('quizzes.none_of_the_above')) && !@options.map(&:text).include?(correct_answer)
        is_correct_answer = (option == correct_answer) || none_is_correct_answer
        add_option(text: option, letter: (index + 65).chr, is_correct_answer: is_correct_answer)
      end
    end
  end
end
