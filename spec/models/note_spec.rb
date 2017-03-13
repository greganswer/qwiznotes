require 'rails_helper'

RSpec.describe Note do
  it "#to_s" do
      note = build(:note)
      expect(note.to_s).to eq(note.title)
    end
end
