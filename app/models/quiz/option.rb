# An `Option` is an answer that a user can select from a question while taking a quiz.
# Each `Option` knows if it is the correct answer, if it has been selected,
# and if it has been answered correctly by the user.
#
class Quiz
  class Option
    attr_reader :text, :letter

    # Initialize a `Quiz` object with an array of `Option`s.
    #
    # @param :text [String] The option's text.
    # @param :letter [String] The option's letter. This is not required.
    # @param :is_correct_answer [Boolean] Is this option the correct answer?
    # @param :is_selected [Boolean] Is this option the selected?
    #
    def initialize(text:, letter: '', is_correct_answer: false, is_selected: false)
        @text = text
        @letter = letter
        @is_correct_answer = is_correct_answer
        @is_selected = is_selected
    end

    def answered_correctly?
      selected? && correct_answer?
    end

    def answered_incorrectly?
      selected? && !correct_answer?
    end

    def correct_answer?
      @is_correct_answer
    end

    def selected?
      @is_selected
    end

    def to_json
      { text: text, letter: letter, is_correct_answer: @is_correct_answer, is_selected: @is_selected }.to_json
    end

    def to_s
      text
    end

    def toggle_select
      @is_selected = !@is_selected
    end
  end
end
