class Note < ApplicationRecord
  DEFAULT_SORT_BY = "notes.created_at"
  DEFAULT_SORT_DIRECTION = "desc"
  MINIMUM_NUMBER_OF_CONCEPTS = Quiz::OPTIONS_COUNT + 1

  belongs_to :user, counter_cache: true
  has_many :comments, as: :item, dependent: :destroy
  has_many :votes, as: :item, dependent: :destroy

  validates :content, presence: true
  after_initialize :set_defaults, unless: :persisted?
  before_validation :prepare_inputs

  #
  # Scopes
  #

  scope :most_voted, -> { order "votes_count DESC" }

  scope :by_voted_by, -> (input) do
    return unless (voted_by = User.find_by name: input[:voted_by])
    ids = Vote.where(user_id: voted_by.id, item_type: model_name.name).pluck(:item_id)
    where id: ids
  end

  #
  # Class methods
  #

  def self.sort_by
    %w(notes.title notes.concepts_count users.name notes.votes_count notes.created_at notes.updated_at)
  end

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

  def prepare_inputs
    self.title = html_clean(self.title.to_s)
    self.title = I18n.t('note.untitled_note') if self.title.blank?
    self.content = html_clean(self.content.to_s)
    @concepts = nil
    self.concepts_count = concepts.count
    self
  end

  #
  # Private
  #

  private

  def set_defaults
    self.content = '' if self.content.blank?
  end
end
