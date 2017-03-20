require 'rails_helper'

RSpec.describe Note do
  it "#to_s" do
    note = Note.new(title: "This is the note I created")
    expect(note.to_s).to eq(note.title)
  end
end
