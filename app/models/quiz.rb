class Quiz
  attr_reader :questions

  OPTIONS_COUNT = 5
  MAX_QUESTIONS_COUNT = 50

  def self.build_from_concepts(concepts)
    quiz = new.tap do |quiz|
      concepts = concepts.sample(MAX_QUESTIONS_COUNT)
      concepts.each_with_index do |concept, index|
        question_is_a_term = rand(2).zero?
        correct_answer = question_is_a_term ? concept[:definition] : concept[:term]
        option_texts = list_of_random_option_texts_except_correct_answer(concepts, question_is_a_term, correct_answer)
        quiz.add_question({
          number: index + 1,
          text: question_is_a_term ? concept[:term] : concept[:definition],
          correct_answer: correct_answer,
          options: create_options_from_option_texts(option_texts, correct_answer)
        })
      end
    end
  end

  def self.build_from_quiz_json(quiz_json, user_answers)
    user_answers = user_answers.with_indifferent_access
    quiz_json = JSON.parse(quiz_json) if quiz_json.is_a?(String)
    quiz = new.tap do |quiz|
      quiz_hash = quiz_json.with_indifferent_access
      quiz_hash[:questions].each do |question|
        is_correct = user_answers[question[:number]] == question[:correct_answer]
        quiz.add_question(question.except(:options).merge({is_correct: is_correct}))
        quiz.add_options_to_last_question(question[:options], user_answers)
      end
    end
  end

  def initialize
    @questions ||= []
  end

  def to_json
    {questions: questions}.to_json
  end

  def add_question(input)
    @questions << Quiz::Question.new(text: input[:text], correct_answer: input[:correct_answer], number: input[:number], options: input[:options])
  end

  def add_options_to_last_question(options, user_answers)
    options.each do |option|
      is_selected = user_answers[questions.last.number.to_s] == option[:text]
      questions.last.add_option(text: option[:text], letter: option[:letter], is_correct_answer: option[:is_correct_answer], is_selected: is_selected)
    end
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

  private

  def self.list_of_random_option_texts_except_correct_answer(concepts, question_is_a_term, correct_answer)
    answer_type = question_is_a_term ? :definition : :term
    options = concepts.map { |item| item[answer_type] }.reject { |item| item  == correct_answer }.sample(OPTIONS_COUNT)
  end

  # Randomly add "None of the above." as the last option then randomly set one of the options as the correct option

  def self.create_options_from_option_texts(option_texts, correct_answer)
    option_texts.tap do |option_texts|
      none_is_an_option = rand(2).zero?
      option_texts[-1] = I18n.t('quizzes.text.none_of_the_above') if none_is_an_option
      random_index = rand(0..option_texts.count - 1)
      option_texts[random_index] = correct_answer unless none_is_an_option && rand(3).zero?
    end
  end
end
