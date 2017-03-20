class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource_or_scope)
    session.fetch 'user_return_to', root_path
  end

  def hashid_decode(id)
    hashids.decode(id)&.first
  end
end
