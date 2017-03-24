class Note < ApplicationRecord
  ## CONSTANTS

  MINIMUM_NUMBER_OF_CONCEPTS = 5

  ## RELATIONS

  belongs_to :user, counter_cache: true

  ## VALIDATIONS

  validates :title, :content, presence: true

  ## CALLBACKS

  before_validation :prepare_input

  ## METHODS

  def to_s
    title
  end

  def concepts(settings_attributes = nil)
    condition = settings_attributes || !@concepts
    @concepts = condition ? CreateNoteConcepts.new(content, settings_attributes).call : @concepts
  end

  def quiz(settings_attributes = nil)
    condition = settings_attributes || !@quiz
    @quiz = condition ? CreateMultipleChoiceQuiz.new(concepts, settings_attributes).call : @quiz
  end

  def quiz_results(quiz_input: quiz, user_answers: [])
    @quiz_results = quiz_input ? CreateMultipleChoiceQuizResults.new(quiz_input, user_answers).call : @quiz_results
  end

  def has_minimum_number_of_concepts?
    concepts.present? && concepts.size >= MINIMUM_NUMBER_OF_CONCEPTS
  end

  ## PRIVATE

  private

  def prepare_input
    self.title = html_clean(title.to_s)
    self.title = I18n.t('notes.untitled_note') if title.blank?
    self.content = html_clean(content.to_s)
    self.concepts_count = concepts.count
  end
end
