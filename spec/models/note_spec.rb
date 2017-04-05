require 'rails_helper'

RSpec.describe Note do
  it { should validate_presence_of(:content) }

  #
  # Methods
  #

  it "fills the empty title" do
    note = build(:note, title: '')
    expect(note.valid?).to be true
    expect(note.title).to eq(t('note.untitled_note'))
  end

  it "#to_s" do
    note = Note.new(title: "This is the note I created")
    expect(note.to_s).to eq(note.title)
  end

  #
  # Concepts methods
  #

  describe "concepts methods" do
    it "#concepts" do
      note = build(:note, content: "apple - a fruit")
      expect(note.concepts).to eq([{term: "Apple", definition: "A fruit."}])
    end

    it "#has_minimum_number_of_concepts?" do
      note = build(:note, content: 'apple - a fruit')
      expect(Note::MINIMUM_NUMBER_OF_CONCEPTS).to eq(6)
      expect(note.has_minimum_number_of_concepts?).to be false
      note = build(:note_with_concepts)
      expect(note.has_minimum_number_of_concepts?).to be true
    end
  end

  #
  # Quiz methods
  #

  describe "quiz methods" do
    let(:note) { build :note_with_concepts }

    it "#quiz has questions" do
      expect(Note.new.quiz).to be_a(Quiz)
      expect(note.quiz.questions.first).to be_a(Quiz::Question)
    end

    it "#quiz_results has questions" do
      expect(Note.new.quiz_results).to be_a(Quiz)
      note.quiz_results(note.quiz.to_json)
      expect(note.quiz_results).to be_a(Quiz)
      expect(note.quiz_results.questions.first).to be_a(Quiz::Question)
    end
  end
end
