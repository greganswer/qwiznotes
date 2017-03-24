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

  ## CONCEPTS

  def concepts(settings_attributes: nil)
    if settings_attributes || !@concepts
      @concepts = CreateNoteConcepts.new(content, settings_attributes).call
    end
    @concepts
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
    # self.category ||= Category.where(name: "Uncategorized").first_or_create!
    self.concepts_count = concepts.count
  end
end
