class Vote < ApplicationRecord
  delegate *%i(to_s), to: :item
  belongs_to :user
  belongs_to :item, counter_cache: true, polymorphic: true

  def find_deleted_item
    item_type.constantize.only_deleted.where(id: item_id).first
  end
end
