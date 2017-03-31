require 'rails_helper'

RSpec.describe Quiz::Option do
  it "can be given text" do
    option = described_class.new(text: 'Greg')
    expect(option.to_s).to eq("Greg")
  end

  it "can have an option letter" do
    option = described_class.new(text: 'Greg', letter: 'A')
    expect(option.letter).to eq('A')
    option = described_class.new(text: 'Greg', letter: 'B')
    expect(option.letter).to eq('B')
  end

  it "knows if it is the correct answer" do
    option = described_class.new(text: 'Greg', is_correct_answer: true)
    expect(option.correct_answer?).to be true
    option = described_class.new(text: 'Greg')
    expect(option.correct_answer?).to be false
  end

  it "knows if it is selected" do
    option = described_class.new(text: 'Greg', is_selected: true)
    expect(option.selected?).to be true
    option = described_class.new(text: 'Greg')
    expect(option.selected?).to be false
  end

  it "knows if it is answered correctly" do
    option = described_class.new(text: 'Greg', is_correct_answer: true, is_selected: true)
    expect(option.answered_correctly?).to be true
    expect(option.answered_incorrectly?).to be false

    option = described_class.new(text: 'Greg', is_selected: true)
    expect(option.answered_correctly?).to be false
    expect(option.answered_incorrectly?).to be true

    option = described_class.new(text: 'Greg', is_correct_answer: true)
    expect(option.answered_correctly?).to be false
    expect(option.answered_incorrectly?).to be false

    option = described_class.new(text: 'Greg')
    expect(option.answered_correctly?).to be false
    expect(option.answered_incorrectly?).to be false
  end

  it "can be converted to JSON" do
    json = described_class.new(text: 'Greg', letter: 'A', is_correct_answer: true, is_selected: true).to_json
    expect(json).to eq('{"text":"Greg","letter":"A","is_correct_answer":true,"is_selected":true}')
  end

  it "can toggle select state" do
    option = described_class.new(text: 'Greg')
    expect(option.selected?).to be false
    option.toggle_select
    expect(option.selected?).to be true
    option.toggle_select
    expect(option.selected?).to be false
  end
end
