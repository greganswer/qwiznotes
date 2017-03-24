class CreateMultipleChoiceQuizResults
  attr_reader :quiz, :settings

  DEFAULT_QUIZ_HASH = {
    correct_selections: [],
    correct_selections_count: 0,
    has_incorrect_selections: false,
    incorrect_selections_count: 0,
    unanswered_count: 0,
  }

  def initialize(quiz_input, user_answers = [])
    user_answers = convert_to_array(user_answers)
    @quiz = quiz_input.merge(user_answers: user_answers).merge(DEFAULT_QUIZ_HASH)
  end

  def call
    set_correct_selections_and_count
    set_correct_percentage
    @quiz
  end

  ## PRIVATE

  private

  def convert_to_array(input)
    return input unless input.is_a?(Hash)
    array_answers = []
    input.each { |key, value| array_answers[key.to_i] = value }
    array_answers
  end

  def set_correct_selections_and_count
    (0..@quiz[:correct_answers].count - 1).each do |q_index|
      if user_answered_correct?(q_index)
        set_values_for_correct_answer(q_index)
      else
        set_values_for_incorrect_answer(q_index)
      end
    end
  end

  def user_answered_correct?(q_index)
    user_answered_none_and_is_correct?(q_index) || user_made_correct_selection?(q_index)
  end

  def user_made_correct_selection?(q_index)
    @quiz[:user_answers][q_index] == @quiz[:correct_answers][q_index]
  end

  def user_answered_none_and_is_correct?(q_index)
    !@quiz[:options][q_index].include?(@quiz[:correct_answers][q_index]) && @quiz[:user_answers][q_index] == "None of the above."
  end

  def set_values_for_correct_answer(q_index)
    @quiz[:correct_selections][q_index] = true
    @quiz[:correct_selections_count] += 1
  end

  def set_values_for_incorrect_answer(q_index)
    @quiz[:correct_selections][q_index] = false
    if @quiz[:user_answers][q_index]
      @quiz[:has_incorrect_selections] = true
      @quiz[:incorrect_selections_count] += 1
    else
      @quiz[:unanswered_count] += 1
    end
  end

  def set_correct_percentage
    nominator = @quiz[:correct_selections_count].to_f
    denominator = @quiz[:questions].count.to_f
    @quiz[:correct_percentage] = (nominator / denominator * 100).to_i
  end
end
