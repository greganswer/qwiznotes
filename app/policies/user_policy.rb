class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
