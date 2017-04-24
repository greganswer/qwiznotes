class Comment < ApplicationRecord
  delegate *%i(to_s), to: :item
  belongs_to :user
  belongs_to :item, polymorphic: true

  validates :item, :content, presence: true

  paginates_per 11

  def find_deleted_item
    item_type.constantize.only_deleted.where(id: item_id).first
  end
end
