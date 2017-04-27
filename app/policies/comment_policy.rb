class CommentPolicy < ApplicationPolicy
  def destroy?
    user.try(:owns?, record) || user.try(:owns?, record.item)
  end
end
