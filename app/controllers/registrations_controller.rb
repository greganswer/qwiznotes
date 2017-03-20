class RegistrationsController < Devise::RegistrationsController
  ## PROTECTED

  protected

  def after_inactive_sign_up_path_for(resource_or_scope)
    session.fetch 'user_return_to', root_path
  end

  def after_sign_up_path_for(resource_or_scope)
    session.fetch 'user_return_to', root_path
  end
end
