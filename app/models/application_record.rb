class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include ApplicationHelper

  ## SCOPES

  scope :recently_created, -> { order('created_at DESC') }
  scope :recently_updated, -> { order('updated_at DESC') }

  def to_param
    hashids.encode(id)
  end
end
