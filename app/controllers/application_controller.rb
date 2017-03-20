class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  protected

  def hashid_decode(id)
    hashids.decode(id)&.first
  end

  ## DEVISE

  def after_inactive_sign_up_path_for(resource_or_scope)
     root_path
  end

  def after_sign_in_path_for(resource_or_scope)
     root_path
  end

  def after_sign_up_path_for(resource_or_scope)
     root_path
  end
end
