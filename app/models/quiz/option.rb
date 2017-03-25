class Quiz
  class Option
    attr_reader :text, :letter

    def initialize(text:, letter: '', is_correct_answer: false, is_selected: false)
        @text = text
        @letter = letter
        @is_correct_answer = is_correct_answer
        @is_selected = is_selected
    end

    def toggle_select!
      @is_selected = !@is_selected
    end

    def to_json
      {
        text: text,
        letter: letter,
        is_correct_answer: @is_correct_answer,
        is_selected: @is_selected,
      }.to_json
    end

    def to_s
      text
    end

    def correct_answer?
      @is_correct_answer
    end

    def selected?
      @is_selected
    end

    def answered_correctly?
      selected? && correct_answer?
    end

    def answered_incorrectly?
      selected? && !correct_answer?
    end
  end
end
