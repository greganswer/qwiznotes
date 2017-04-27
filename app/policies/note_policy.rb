class NotePolicy < ApplicationPolicy
  def quiz?
    true
  end

  def review?
    true
  end

  def autocomplete?
    true
  end

  def quiz_results?
    true
  end

  def permitted_attributes
    %i(title content)
  end
end
