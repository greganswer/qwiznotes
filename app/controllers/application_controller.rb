class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :set_locale

  #
  # Protected
  #

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # NOTE: If this return value is changed, make sure it is changed in the corresponding `config/environments/*.rb` files that also have the `locale` key for their `default_url_options`
  #
  def default_url_options(options = {})
    { locale: I18n.locale || "en" }
  end
end
