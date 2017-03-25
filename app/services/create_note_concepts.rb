class CreateNoteConcepts
  attr_reader :definition, :line, :lines, :settings, :term

  ## CONSTANTS

  CONCEPT_SEPARATORS = {
    acceptable_styles: {
      bold: "<\/b>|<\/strong>",
      definition_list: "<\/dt>",
    },
    acceptable_symbols: {
      arrow: "\s*->\s*|\s*-&gt;\s*",
      dash: "ndash;|mdash;",
      colon: ":",
      equal: "=",
      tilde: "~",
      hyphen: " -",
    },
  }

  SETTINGS = {
    accept_styling: true,
    accept_symbols: true,
    add_period: true,
    capitalize: true,
    bold: true,
    definition_list: true,
    arrow: true,
    dash: true,
    colon: true,
    equal: true,
    tilde: true,
    hyphen: true,
  }

  HTML_TAGS = {bold: %w(b strong), definition_list: %w(dt)}

  def initialize(content, settings_attributes = nil)
    @term = @definition = ""
    @settings = settings_attributes&.symbolize_keys&.slice(*SETTINGS.keys) || SETTINGS
    @lines = content.split(%r{<br.*?>|<\/p>})
  end

  def call
    lines.map!(&method(:convert_line))
    lines.reject { |concept| concept[:definition].blank? }
  end

  ## PROTECTED

  protected

  def definition=(value)
    @definition = value.to_s.strip.gsub(/&amp;/, "&")
  end

  def line=(value)
    @line = value.to_s.strip
  end

  def term=(value)
    @term = value.to_s.strip.gsub(/&amp;/, "&")
  end

  def convert_line(line_input)
    self.term = self.definition = nil
    self.line = line_input
    first_pass_on_line
    second_pass_on_line
    additional_processing_on_line
    {term: term, definition: definition}
  end

  def html_sanitize(input, with_tags: false)
    tags = with_tags ? HTML_TAGS.values.flatten : []
    input = input.gsub(/&mdash;/, "mdash;").gsub(/&ndash;/, "ndash;")
    ActionController::Base.helpers.sanitize(input, tags: tags)
  end

  ## PRIVATE

  private

  def first_pass_on_line
    return unless settings[:accept_styling]
    self.line = html_sanitize line, with_tags: true
    process_line_using(:acceptable_styles)
  end

  def second_pass_on_line
    return unless settings[:accept_symbols]
    return if term.present? && definition.present?
    self.line = html_sanitize line
    process_line_using(:acceptable_symbols)
  end

  def process_line_using(separator_type)
    default_separators = CONCEPT_SEPARATORS[separator_type]
    keys = settings.reject { |_key, value| value.blank? }.keys || default_separators.keys
    keys.map!(&:to_sym)
    regex = /#{default_separators.slice(*keys).values.join("|")}/
    self.term, self.definition = line.split(regex, 2).map do |part|
      html_sanitize part.gsub("&nbsp;", " ")
    end
  end

  ##  ADDITIONAL PROCESSING

  def additional_processing_on_line
    settings.each { |key, value| send(key, value) if respond_to?(key, true) }
  end

  def add_period(_)
    definition << "." if settings[:add_period] && definition[/[^[?.!,;]]+$/]
  end

  def capitalize(_)
    return unless settings[:capitalize]
    term[0] = term[0]&.capitalize.to_s unless term[1].to_s[/[A-Z]/]
    definition[0] = definition[0]&.capitalize.to_s unless definition[1].to_s[/[A-Z]/]
  end
end
