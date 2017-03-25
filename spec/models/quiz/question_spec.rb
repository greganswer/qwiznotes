require 'rails_helper'

RSpec.describe Quiz::Question do
  it "should have a question, a question number, and a correct answer" do
    question = described_class.new(text: "What's your name?", correct_answer: 'Greg', number: 1)
    expect(question.to_s).to eq("What's your name?")
    expect(question.number).to eq(1)
    expect(question.correct_answer).to eq("Greg")
  end

  it "automatically adds a question mark" do
    question = described_class.new(text: "What's your name", correct_answer: 'Greg')
    expect(question.to_s).to eq("What's your name?")
  end

  it "has options" do
    options = ['John', 'Greg', 'David']
    question = described_class.new(text: "What's your name?", correct_answer: 'Greg', options: options)
    expect(question.options.first).to be_kind_of(Quiz::Option)
    expect(question.options.first.to_s).to eq('John')
  end

  it "can add options" do
    question = described_class.new(text: "What's your name?", correct_answer: 'Greg')
    question.add_option(text: 'Greg', letter: 'a')
    expect(question.options.first).to be_kind_of(Quiz::Option)
    expect(question.options.first.to_s).to eq('Greg')
  end

  it "can be converted to JSON" do
    options = ['John', 'Greg', 'David']
    question = described_class.new(text: "What's your name?", correct_answer: 'Greg', number: 1, options: options)
    expected = {
      text: "What's your name?",
      number: 1,
      correct_answer: "Greg",
      options: [
        {text: 'John', letter: 'A', is_correct_answer: false, is_selected: false},
        {text: 'Greg', letter: 'B', is_correct_answer: true, is_selected: false},
        {text: 'David', letter: 'C', is_correct_answer: false, is_selected: false}
      ]
    }
    expect(question.to_json).to eq(expected.to_json)
  end

  context "option selection" do
    let(:options) { ['John', 'Greg', 'David'] }
    let(:question) { described_class.new(text: "What's your name?", correct_answer: 'Greg', options: options) }

    it "knows if it is answered correctly" do
      question.toggle_select_for_option('B')
      expect(question).to be_answered
      expect(question).to be_answered_correctly
    end

    it "knows if it is not answered correctly" do
      question.toggle_select_for_option('A')
      expect(question).to be_answered
      expect(question).not_to be_answered_correctly
    end

    it "knows if it is unanswerd" do
      expect(question).not_to be_answered
    end
  end
end
