class Note < ApplicationRecord

  MINIMUM_NUMBER_OF_CONCEPTS = Quiz::OPTIONS_COUNT + 1

  belongs_to :user, counter_cache: true
  validates :content, presence: true
  after_initialize :set_defaults, unless: :persisted?
  before_validation :prepare_input

  #
  # Instance methods
  #

  def to_s
    title
  end

  def concepts(settings_attributes = nil)
    @concepts ||= []
    return @concepts if @concepts.present? || settings_attributes
    @concepts = CreateConceptsFromContent.new(content, settings_attributes).call
  end

  def has_minimum_number_of_concepts?
    concepts.count >= MINIMUM_NUMBER_OF_CONCEPTS
  end

  def quiz
    @quiz ||= Quiz.build_from_concepts(self.concepts)
  end

  def quiz_results(quiz_hash = nil, user_answers = {})
    return @quiz_results ||= Quiz.new unless quiz_hash
    @quiz_results = Quiz.build_from_quiz_hash(quiz_hash, user_answers)
  end

  #
  # Private
  #

  private

  def set_defaults
    self.content = '' if self.content.blank?
  end

  def prepare_input
    self.title = html_clean(self.title.to_s)
    self.title = I18n.t('note.untitled_note') if self.title.blank?
    self.content = html_clean(self.content.to_s)
    self.concepts_count = concepts.count
  end
end
