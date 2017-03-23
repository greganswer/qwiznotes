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
end
