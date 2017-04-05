class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  #
  # Get
  #

  def edit?
    update?
  end

  def index?
    true
  end

  def new?
    create?
  end

  def show?
    true
  end

  #
  # Post/Patch
  #

  def create?
    user.present?
  end

  ## PATCH

  def update?
    user.try(:owns?, record)
  end

  def restore?
    user.try(:owns?, record)
  end

  #
  # Delete
  #

  def destroy?
    user.try(:owns?, record)
  end

  #
  # Scope
  #

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
