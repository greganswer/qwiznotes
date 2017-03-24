class CreateMultipleChoiceQuiz
  attr_accessor :correct_answers, :options, :questions
  attr_reader :concepts, :option_types, :settings

  def initialize(concepts, settings_attributes = nil)
    @questions, @options, @correct_answers, @option_types = Array.new(4) { [] }
    @concepts = concepts.try(:shuffle)
    self.settings = settings_attributes
  end

  def call
    return [] if has_no_concepts?
    set_quiz_questions_and_correct_answers
    set_quiz_options
    return_multiple_choice_hash
  end

  def has_no_concepts?
    concepts.blank? || concepts[0][:definition].blank?
  end

  protected

  def return_multiple_choice_hash
    {
      questions: questions,
      options: options,
      correct_answers: correct_answers,
    }
  end

  def settings=(input)
    input = input.try(:symbolize_keys)
    @settings = default_settings.merge(input || {})
    if @settings[:max_number_of_questions].zero?
      @settings[:max_number_of_questions] = concepts.size
    end
    @settings
  end

  private

  def default_settings
    {
      max_number_of_questions: concepts.size,
      options_per_question: 5,
      add_none_of_above: true,
    }
  end

  def set_quiz_questions_and_correct_answers
    (0..settings[:max_number_of_questions] - 1).each do |q_index|
      bool = (rand 1 + 1) == 1
      question_type = bool ? :definition : :term
      answer_type = bool ? :term : :definition

      questions << concepts[q_index][question_type].gsub(/[?.!,;]+$/, "")
      correct_answers << concepts[q_index][answer_type]
      option_types << answer_type
    end
  end

  def set_quiz_options
    (0..settings[:max_number_of_questions] - 1).each do |q_index|
      o_index = concepts_index = 0

      while o_index < settings[:options_per_question]
        concepts_index += 1
        concepts_index = 0 unless concepts[concepts_index].present?
        next if q_index == concepts_index

        term_or_definition_key = option_types[q_index]
        (options[q_index] ||= []) << concepts[concepts_index][term_or_definition_key]
        o_index += 1
      end
      set_correct_option_and_or_none_of_the_above(q_index)
    end
  end

  # Randomly set the correct option based on the range.
  # Add "None of the above." to the last option if is_none_an_option is true and randomly include the correct answer as an option.
  # The correct option CANNOT be the last option, if none of the above is included.
  def set_correct_option_and_or_none_of_the_above(q_index)
    is_none_an_option = settings[:add_none_of_above] && (rand 1 + 1) == 1
    range = settings[:options_per_question] - (is_none_an_option ? 2 : 1)
    if !is_none_an_option || rand(2) == 1
      options[q_index][rand(0..range)] = correct_answers[q_index]
    end
    options[q_index][-1] = "None of the above." if is_none_an_option
  end
end
