class Note < ApplicationRecord
  ## VALIDATIONS

  validates :title, :content, presence: true

  ## CALLBACKS

  before_validation :prepare_input

  ## METHODS

  def to_s
    title
  end

  ## PRIVATE

  private

  def prepare_input
    self.title = html_clean(title.to_s)
    self.title = I18n.t('notes.untitled_note') if title.blank?
    self.content = html_clean(content.to_s)
    # self.category ||= Category.where(name: "Uncategorized").first_or_create!
    # self.concepts_count = concepts.count
  end
end
