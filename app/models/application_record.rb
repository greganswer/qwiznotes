class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ApplicationHelper

  #
  # Scopes
  #

  scope :by_created, -> { order "#{table_name}.created_at ASC" }
  scope :by_updated, -> { order "#{table_name}.updated_at ASC" }
  scope :recently_created, -> { order "#{table_name}.created_at DESC" }
  scope :recently_updated, -> { order "#{table_name}.updated_at DESC" }

  #
  # Hashids
  #

  def self.hashids
    Hashids.new(Rails.application.secrets.secret_key_base, 8)
  end

  def self.hashid_decode(hashid)
    hashids.decode(hashid)&.first
  end

  def self.find_using_hashid(hashid)
    find(hashid_decode(hashid))
  end

  def css_class
    "#{model_name.singular} #{model_name.singular}_#{id}"
  end

  def to_param
    self.class.hashids.encode(id)
  end
end
