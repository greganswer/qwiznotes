# A `Quiz` has many questions and each question has many options. A quiz can be built from an
# array of `term` and `definition` pairs or a hash of quiz data. When built from a hash of
# quiz data, the quiz has additional data such as number of correct answers,
# incorrect answers, and unanswered questions.
#
class Quiz
  extend ActiveModel::Naming

  attr_reader :questions

  OPTIONS_COUNT = 5
  MAX_QUESTIONS_COUNT = 50

  # Converts the [Array] of `term` and `definition` pairs into a [Quiz]
  # There should be at least `OPTIONS_COUNT` + 1 concepts in order to make a quiz (6 concepts)
  #
  # @param concepts [Array] An array of `term` and `definition` pairs.
  # @return quiz [Quiz]
  #
  # @example
  #   concepts = [{ term: "Apple", definition: "A red fruit" }, { term: "Car", definition: "A 4 wheeled motor vehicle" }]
  #
  def self.build_from_concepts(concepts)
    quiz = new
    concepts = concepts.sample(MAX_QUESTIONS_COUNT)
    concepts.each_with_index do |concept, index|
      question_is_a_term = rand(2).zero?
      text = question_is_a_term ? concept[:term] : concept[:definition]
      correct_answer = question_is_a_term ? concept[:definition] : concept[:term]
      option_texts = random_option_texts_except_correct_answer(concepts, question_is_a_term, correct_answer)
      options = create_options_from_option_texts(option_texts, correct_answer)
      quiz.add_question({ number: index + 1, text: text, correct_answer: correct_answer, options: options })
    end
    quiz
  end

  # Take JSON input of quiz data and create a quiz object.
  # This is used to recreate a quiz with user answers and results
  # (with the same order of questions and optoions, no randomness)
  #
  # @param quiz_hash [String, Hash] The JSON or Hash of `Quiz` properties.
  # @param user_answers [Hash] The user answers `params` from the controller.
  # @return [Quiz]
  #
  # @example
  #   options = [ { text: "Apple", letter: 'A', is_correct_answer: true, is_selected: false }, ... ]
  #   quiz_hash  # => { text: "Red Fruit?", number: 1, correct_answer: "Apple", options: options }
  #   user_answers  # => {"1": "Apple", "2": "A 4 wheeled motor vehicle"}
  #
  def self.build_from_quiz_hash(quiz_hash, user_answers)
    user_answers = user_answers.with_indifferent_access
    # FIXME: This method should be able to take either a JSON or an Array of Hashes without the need for rescue
    quiz_hash = JSON.parse(quiz_hash).with_indifferent_access rescue quiz_hash
    quiz = new
    quiz_hash[:questions].each do |question|
      quiz.add_question(question.except(:options)).build_options_from_hash(question[:options], user_answers)
    end
    quiz
  end

  def initialize
    @questions ||= []
  end

  def to_json
    { questions: questions }.to_json
  end

  def add_question(input)
    Quiz::Question.new(input.symbolize_keys).tap { |question| @questions << question }
  end

  def correct_answers
    @correct_answers ||= questions.select { |question| question.answered_correctly? }
  end

  def incorrect_answers
    @incorrect_answers ||= questions.select { |question| question.answered_incorrectly? }
  end

  def unanswerd_questions
    @unanswerd_questions ||= questions.select { |question| !question.answered? }
  end

  def percent_correct
    (correct_answers.count * 100 / questions.count).floor
  end

  #
  # Private
  #

  private

  def self.random_option_texts_except_correct_answer(concepts, question_is_a_term, correct_answer)
    answer_type = question_is_a_term ? :definition : :term
    concepts.map { |item| item[answer_type] }.reject { |item| item  == correct_answer }.sample(OPTIONS_COUNT)
  end

  # Randomly add "None of the above." as the last option then randomly set one of the options as the correct option.
  #
  # @param option_texts [Array<String>] Strings that will become the text for the `Option` objects.
  # @param correct_answer [String] The correct answer (and therefore the correct option to select).
  # @return option_texts [Array<String>]
  # @!visibility private
  #
  def self.create_options_from_option_texts(option_texts, correct_answer)
    none_is_an_option = rand(2).zero?
    option_texts[-1] = I18n.t('quizzes.none_of_the_above') if none_is_an_option
    random_index = rand(0..option_texts.count - 1)
    option_texts[random_index] = correct_answer unless none_is_an_option && rand(3).zero?
    option_texts
  end
end
