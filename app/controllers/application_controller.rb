class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  protected

  def hashid_decode(id)
    hashids.decode(id)&.first
  end
end
