# A `Question` is part of a quiz and each question can have many options. Each `Question` knows
# if it is the correct answer and if it has been answered correctly by the user.
#
class Quiz
  class Question
    attr_reader :text, :options, :number, :correct_answer

    # Initialize a `Quiz` object with an array of `Option`s
    #
    # @param :text [String] The question text.
    #   All punctuation is removed from the end a question mark is added.
    # @param :correct_answer [String] The correct answer to the question.
    # @param :number [String] The number of the question. This is not required.
    # @param :options [Array<String>] An array of options for the question
    #
    def initialize(text:, correct_answer:, number: '', options: [])
      @text = text.sub(/[,!\.\?]$/, '') + '?'
      @number = number
      @correct_answer = correct_answer
      @options = []
      build_options_from_array_of_strings(options) if options.present?
    end

    # Add options to this question via a JSON Array of Hashes or a Ruby Array of Hashes
    #
    # @param options_array [Hash] The hash of `Option` properties.
    # @param user_answers [Hash] The user answers `params` from the controller
    #
    def build_options_from_hash(options_array, user_answers = {})
      # FIXME: This method should be able to take either a JSON or an Array of Hashes without the need for rescue
      options_array = JSON.parse(options_array).with_indifferent_access rescue options_array
      options_array.each do |option_hash|
        is_selected = user_answers[number.to_s] == option_hash[:text]
        build_option(option_hash.merge(is_selected: is_selected))
      end
      options
    end

    def build_option(input)
      @options << Quiz::Option.new(input.symbolize_keys)
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
      options.select { |option| option.letter.downcase == letter.downcase }&.first&.toggle_select
    end

    def to_json
      { text: text, number: number, correct_answer: correct_answer, options: options }.to_json
    end

    def to_s
      text
    end

    #
    # Private
    #

    private

    # Take an array of text and convert them to an array of `Option`s
    #
    # @param selection [Array] Strings that will become the text for the `Option` objects
    # @note: "None of the above." is the correct answer if the array of text does not include the correct answer
    #
    def build_options_from_array_of_strings(selection)
      selection.each_with_index do |option, index|
        none_is_correct_answer =  (option == I18n.t('quizzes.none_of_the_above')) && !@options.map(&:text).include?(correct_answer)
        is_correct_answer = (option == correct_answer) || none_is_correct_answer
        build_option(text: option, letter: (index + 65).chr, is_correct_answer: is_correct_answer)
      end
    end
  end
end
