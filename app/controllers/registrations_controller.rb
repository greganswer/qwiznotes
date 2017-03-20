class RegistrationsController < Devise::RegistrationsController
  ## PROTECTED

  protected

  def after_inactive_sign_up_path_for(resource_or_scope)
    after_sign_up_path_for(resource)
  end

  # def after_sign_up_path_for(resource_or_scope)
  #   session.fetch 'user_return_to', notes_path
  # end
end
