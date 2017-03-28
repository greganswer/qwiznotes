class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ApplicationHelper

  #
  # Scopes
  #

  scope :recently_created, -> { order "#{table_name}.created_at DESC" }
  scope :recently_updated, -> { order "#{table_name}.updated_at DESC" }

  #
  # Hashids
  #

  def self.hashids
    Hashids.new(Rails.application.secrets.secret_key_base, 8)
  end

  def self.find_by_hashid(hashid)
    find(hashids.decode(hashid)&.first)
  end

  def to_param
    self.class.hashids.encode(id)
  end
end
