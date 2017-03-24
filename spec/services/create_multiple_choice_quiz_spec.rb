require "rails_helper"

describe CreateMultipleChoiceQuiz do
  subject { described_class.new }

  let(:concepts) do
    [
      { term: "Banana", definition: "Yellow Fruit." },
      { term: "Cat", definition: "Feline animal." },
      { term: "Computer", definition: "Technological devise." },
      { term: "Crest", definition: "Top of hill; summit." },
      { term: "Flummox", definition: "To perplex or bewilder." },
    ]
  end

  ## DEFAULT SETTINGS

  %i(questions options correct_answers).each do |key|
    it "has the correct count for #{key}" do
      quiz = described_class.new(concepts).call
      expect(quiz[key].count).to eq(concepts.count)
    end
  end

  ## DIFFERENT SETTINGS

  it "can limit the number of options per question" do
    quiz = described_class.new(concepts, { options_per_question: 3 }).call
    expect(quiz[:options][0].count).to eq(3)
  end

  context "with max_number_of_questions set it has the correct count for" do
    %i(questions options correct_answers).each do |key|
      it "#{key}" do
        quiz = described_class.new(concepts, { max_number_of_questions: 3 }).call
        expect(quiz[key].count).to eq(3)
      end
    end
  end

  context "with max_number_of_questions set to 0 it has the correct count for" do
    %i(questions options correct_answers).each do |key|
      it "#{key}" do
        quiz = described_class.new(concepts, { max_number_of_questions: 0 }).call
        expect(quiz[key].count).to eq(concepts.count)
      end
    end
  end
end
