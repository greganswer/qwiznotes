require "rails_helper"

describe CreateConceptsFromContent do
  subject { described_class.new }

  before(:each) { @settings_attributes = described_class::SETTINGS }
  let(:expected) do
    [{ term: "Crest", definition: "Hill top; peak & summit." }]
  end

  #
  # Html formatting
  #

  describe "HTML formatting" do
    context "bolded text" do
      contents = [
        "<b>crest </b> hill top; peak & summit",
        '<b style="text-align: left;">crest </b> hill top; peak & summit',
        "<strong>crest </strong> hill top; peak & summit",
      ]
      contents.each do |content|
        it "converts" do
          expect(described_class.new(content).call).to eq(expected)
        end
      end
    end

    context "definition list" do
      it "converts" do
        content = "<dt>crest </dt><dd>hill top; peak & summit<dd>"
        expect(described_class.new(content).call).to eq(expected)
      end
    end
  end

  #
  # Symbols
  #

  describe "symbols" do
    symbols = ["&ndash;", "&mdash;", ":", "=", "~"]
    symbols.each do |symbol|
      it "converts #{symbol} symbol touching left word" do
        content = "crest#{symbol} hill top; peak & summit"
        expect(described_class.new(content).call).to eq(expected)
      end
    end

    symbols += ["->", "-&gt;", "-"]
    symbols.each do |symbol|
      it "converts #{symbol} symbol in the middle" do
        content = "crest #{symbol} hill top; peak & summit"
        expect(described_class.new(content).call).to eq(expected)
      end

      it "converts #{symbol} symbol touching right word" do
        content = "crest #{symbol}hill top; peak & summit"
        expect(described_class.new(content).call).to eq(expected)
      end
    end
  end

  #
  # Specify separators
  #

  describe "user can specify separators" do
    before(:each) do
      @content = "<dl><dt>crest</dt> <dd>hill top; peak & summit</dd></dl>"
    end

    samples = {
      bold: "<b>antonym </b> word of opposite meaning",
      arrow: "antonym -> word of opposite meaning",
      dash: "antonym &mdash; word of opposite meaning",
      colon: "antonym: word of opposite meaning",
      equal: "antonym = word of opposite meaning",
      tilde: "antonym ~ word of opposite meaning",
      hyphen: "antonym - word of opposite meaning",
    }
    samples.each do |key, value|
      it "converts when #{key} is set to false" do
        @content = "#{@content} <br> #{value}"
        @settings_attributes = @settings_attributes.merge(key => false)
        @settings_attributes[:hyphen] = false if key == :arrow
        expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
      end
    end
  end

  #
  # Additional cases
  #

  describe "additional cases" do
    it "converts when wrapped in a paragraph tag" do
      content =  '<p style="text-align: left;">crest -&gt; hill top; peak & summit</p>'
      expect(described_class.new(content).call).to eq(expected)
    end

    it "respects hyphenated words" do
      expected = [{ term: "Re-fit", definition: "To fit again." }]
      expect(described_class.new("re-fit - to fit again").call).to eq(expected)
    end
  end

  #
  # Additional settings
  #

  describe "additional settings" do
    before(:each) { @content = "<b>crest </b> hill top; peak & summit" }

    it "multi-line input" do
      @content += "<br> apple - a fruit"
      expected = [
        { term: "Crest", definition: "Hill top; peak & summit." },
        { term: "Apple", definition: "A fruit." },
      ]
      expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
    end

    it "does not capitalize if the first word is an acronym" do
      @content = "UN - united Nations"
      expected = [{ term: "UN", definition: "United Nations." }]
      expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
    end

    it "disable add period" do
      @settings_attributes = @settings_attributes.merge(add_period: false)
      expected = [{ term: "Crest", definition: "Hill top; peak & summit" }]
      expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
    end

    it "disable capitalize" do
      @settings_attributes = @settings_attributes.merge(capitalize: false)
      expected = [{ term: "crest", definition: "hill top; peak & summit." }]
      expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
    end

    it "disable accept_styling" do
      @content += "<br> apple - a fruit"
      @settings_attributes = @settings_attributes.merge(accept_styling: false)
      expected = [{ term: "Apple", definition: "A fruit." }]
      expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
    end

    it "disable accept_symbols" do
      @content += "<br> apple - a fruit"
      @settings_attributes = @settings_attributes.merge(accept_symbols: false)
      expected = [{ term: "Crest", definition: "Hill top; peak & summit." }]
      expect(described_class.new(@content, @settings_attributes).call).to eq(expected)
    end
  end
end
