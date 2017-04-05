require 'rails_helper'

RSpec.describe Quiz do
  let(:concepts) do
    [
      { term: "Apple", definition: "Red Fruit." },
      { term: "Banana", definition: "Yellow Fruit." },
      { term: "Cat", definition: "Feline animal." },
      { term: "Car", definition: "Four wheeled vehicle." },
      { term: "Computer", definition: "Technological devise." },
      { term: "Crest", definition: "Top of hill; summit." },
      { term: "Flummox", definition: "To perplex or bewilder." },
    ]
  end

  it "can be created from concepts" do
    quiz = Quiz.build_from_concepts(concepts)
    question = quiz.questions.first
    expect(quiz.questions.count).to eq(7)
    expect(question).to be_kind_of(Quiz::Question)
    expect(question.to_s).to be_kind_of(String)
    expect(question.options.first).to be_kind_of(Quiz::Option)
    expect(question.options.count).to eq(5)
  end

  #
  # Quiz results
  #

  context "quiz results" do
    let(:correct_answer)  { "Apple" }
    let(:quiz_hash)  do
      json = { questions: [] }
      options = [
        { text: "Apple", letter: 'A', is_correct_answer: true, is_selected: false },
        { text: "Banana", letter: 'B', is_correct_answer: false, is_selected: false },
        { text: "Cat", letter: 'C', is_correct_answer: false, is_selected: false },
        { text: "Car", letter: 'D', is_correct_answer: false, is_selected: false },
      ]
      3.times do |index|
        json[:questions] <<  { text: "Red Fruit?", number: index + 1, correct_answer: correct_answer, options: options }
      end
      json
    end

    it "knows the number of correct answers" do
      user_answers = {"1": correct_answer}
      quiz = Quiz.build_from_quiz_hash(quiz_hash, user_answers)
      expect(quiz.correct_answers.count).to eq(1)
      expect(quiz.incorrect_answers.count).to eq(0)
      expect(quiz.unanswerd_questions.count).to eq(2)
      expect(quiz.percent_correct).to eq(33)
    end

    it "knows the number of incorrect answers" do
      user_answers = {"1": "Banana"}
      quiz = Quiz.build_from_quiz_hash(quiz_hash, user_answers)
      expect(quiz.correct_answers.count).to eq(0)
      expect(quiz.incorrect_answers.count).to eq(1)
      expect(quiz.unanswerd_questions.count).to eq(2)
      expect(quiz.percent_correct).to eq(0)
    end

    it "knows the number of unanswered questions" do
      user_answers = {}
      quiz = Quiz.build_from_quiz_hash(quiz_hash, user_answers)
      expect(quiz.correct_answers.count).to eq(0)
      expect(quiz.incorrect_answers.count).to eq(0)
      expect(quiz.unanswerd_questions.count).to eq(3)
      expect(quiz.percent_correct).to eq(0)
    end
  end
end
