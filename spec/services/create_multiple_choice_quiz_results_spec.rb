require "rails_helper"

describe CreateMultipleChoiceQuizResults do
  subject { described_class.new(quiz_input, user_answers).call }

  let(:options_per_question) { 5 }
  let(:quiz_input) { CreateMultipleChoiceQuiz.new(concepts).call }

  let(:concepts) do
    [
      { term: "Banana", definition: "Yellow Fruit." },
      { term: "Cat", definition: "Feline animal." },
      { term: "Computer", definition: "Technological devise." },
      { term: "Crest", definition: "Top of hill; summit." },
      { term: "Flummox", definition: "To perplex or bewilder." },
    ]
  end

  let(:user_answers) do
    answers = {}
    (concepts.count - 1).times do |num|
      answers[num.to_s] = rand(0..options_per_question - 1)
    end
    answers
  end

  %i(questions options correct_answers).each do |key|
    it "has the correct count for #{key}" do
      expect(subject[key].count).to eq(concepts.count)
    end
  end

  it "has incorrect selections" do
    expect(subject[:has_incorrect_selections]).to eq(true)
  end

  it "has incorrect selections count" do
    incorrect_selections = subject[:correct_selections].count false
    expect(subject[:incorrect_selections_count]).to eq(4)
  end

  it "has correct selections count" do
    correct_selections = subject[:correct_selections].count true
    expect(subject[:correct_selections_count]).to eq(correct_selections)
  end

  it "has unanswered count" do
    expect(subject[:unanswered_count]).to eq(1)
  end

  it "has user_answers count" do
    expect(subject[:user_answers].count).to eq(user_answers.count)
  end

  it "has correct_percentage" do
    correct = subject[:correct_selections_count].to_f
    questions = subject[:questions].count.to_f
    percentage = (correct / questions * 100).to_i
    expect(subject[:correct_percentage]).to eq(percentage)
  end
end
