class NotePolicy < ApplicationPolicy
  def quiz?
    true
  end

  def review?
    true
  end

  def quiz_results?
    true
  end

  def permitted_attributes
    %i(title content)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
