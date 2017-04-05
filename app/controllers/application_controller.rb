class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_locale
  after_action :store_location
  after_action :verify_authorized, except: :index, unless: :devise_controller?

  #
  # Execption handling
  #

  # All 400 and 500 errors are passed to `render_error_template()` in this controller
  # NOTE: comment out the `unless` block in order to mimic production response
  #
  # unless Rails.application.config.consider_all_requests_local
    # rescue_from Exception, with: ->(exception) { render_error_template 500, exception }
    # exception_clasess = [
    #   ActionController::RoutingError,
    #   ActionController::UnknownController,
    #   ::AbstractController::ActionNotFound,
    #   ActiveRecord::RecordNotFound
    # ]
    # rescue_from *exception_clasess, with: ->(exception) { render_error_template 404, exception }
  # end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  #
  # Protected
  #

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def store_location
    return unless request.get?
    return if request.fullpath.match("/account") || request.xhr?
    session[:previous_url] = request.fullpath
  end

  # NOTE: If this return value is changed, make sure it is changed in the corresponding
  # `config/environments/*.rb` files that also have the `locale` key for their `default_url_options`
  #
  def default_url_options(options = {})
    { locale: I18n.locale || "en" }
  end

  #
  # Private
  #

  private

  def render_error_template(status, _exception)
    respond_to do |format|
      template = "application/error_#{status}"
      format.html { render template: template, status: status }
      format.all { render nothing: true, status: status }
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    translation = "#{policy_name}.#{pundit_method_scope(exception.query)}"
    flash[:alert] = t(translation, scope: "pundit", default: :default)

    respond_to do |format|
      format.html { redirect_to(request.referrer || root_path) }
      format.all { render nothing: true, status: :unauthorized }
    end
  end

  def pundit_method_scope(method)
    case method
    when "create?"
      "new?"
    when "update?"
      "edit?"
    else
      method
    end
  end
end
