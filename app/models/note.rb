class Note < ApplicationRecord
  MINIMUM_NUMBER_OF_CONCEPTS = Quiz::OPTIONS_COUNT + 1

  belongs_to :user, counter_cache: true

  validates :title, :content, presence: true

  before_validation :prepare_input

  def to_s
    title
  end

  def concepts(settings_attributes = nil)
    condition = settings_attributes || !@concepts
    @concepts = condition ? CreateConceptsFromContent.new(content, settings_attributes).call : @concepts
  end

  def has_minimum_number_of_concepts?
    concepts.present? && concepts.size >= MINIMUM_NUMBER_OF_CONCEPTS
  end

  def quiz
    @quiz ||= Quiz.build_from_concepts(concepts)
  end

  def quiz_results(quiz_hash = nil, user_answers = {})
    @quiz_results = quiz_hash ? Quiz.build_from_quiz_hash(quiz_hash, user_answers) : @quiz_results
  end

  #
  # Private
  #

  private

  def prepare_input
    self.title = html_clean(title.to_s)
    self.title = I18n.t('notes.untitled_note') if title.blank?
    self.content = html_clean(content.to_s)
    self.concepts_count = concepts.count
  end
end
