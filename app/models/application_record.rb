class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include ApplicationHelper

  def to_param
    hashids.encode(id)
  end
end
