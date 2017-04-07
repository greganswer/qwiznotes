class ApplicationController < ActionController::Base

  #
  # Protected
  #

  protected

  include ApplicationHelper
  include Pundit

  protect_from_forgery with: :exception
  around_action :with_timezone
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_user
  before_action :current_company
  before_action :current_employee
  before_action :set_locale
  after_action :store_location
  after_action :verify_authorized, except: :index, unless: :devise_controller?

  #
  # Devise
  #

  def configure_permitted_parameters
    keys = %w(first_name last_name email)
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  #
  # Pundit
  #

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    @pundit_user ||= PolicyContext.new({
      company: @current_company,
      params: params,
      user: @current_user,
      employee: @current_employee,
    })
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

  #
  # Additional
  #

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

  # @reference: http://thisbythem.com/blog/clientside-timezone-detection/
  #
  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
