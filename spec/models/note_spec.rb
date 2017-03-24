require 'rails_helper'

RSpec.describe Note do
  ## VALIDATIONS

  it { should validate_presence_of(:content) }

  ## METHODS

  it "fills the empty title" do
    note = build(:note, title: '')
    expect(note.valid?).to be true
    expect(note.title).to eq(t('notes.untitled_note'))
  end

  it "#to_s" do
    note = Note.new(title: "This is the note I created")
    expect(note.to_s).to eq(note.title)
  end

  ## CONCEPTS METHODS

  describe "CONCEPTS METHODS" do
    it "#concepts" do
      note = build(:note, content: "apple - a fruit")
      expect(note.concepts).to eq([{term: "Apple", definition: "A fruit."}])
    end

    it "#has_minimum_number_of_concepts?" do
      note = build(:note, content: 'apple - a fruit')
      expect(note.has_minimum_number_of_concepts?).to be false
      note = build(:note)
      expect(note.has_minimum_number_of_concepts?).to be true
    end
  end

  ## QUIZ METHODS

  describe "QUIZ METHODS" do
    let(:note) { build :note }

    it "#quiz has questions" do
      expect(note.quiz[:questions][0]).to be_truthy
    end

    it "#quiz_results has questions" do
      quiz_results = note.quiz_results(quiz_input: note.quiz)
      expect(quiz_results[:questions][0]).to be_truthy
    end
  end
end
