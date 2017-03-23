module ApplicationHelper
  include ActionView::Helpers::OutputSafetyHelper

  ## CONSTANTS

  SAFE_HTML_TAGS = %w(
    a abbr acronym address area b bdo big blockquote br button caption center cite code col colgroup dd del dfn dir div dl dt em fieldset font form h1 h2 h3 h4 h5 h6 hr i img input ins kbd label legend li map mark menu ol optgroup option p pre q s samp select small span strike strong sub sup table tbody td textarea tfoot th thead u tr tt u ul var
  )

  ## CONTROLLER

  def controller_collection_instance
    instance_variable_get("@#{controller_name}")
  end

  def controller_member_instance
    instance_variable_get("@#{controller_name}".singularize)
  end

  def hashids
    Hashids.new(Rails.application.secrets.secret_key_base, 8)
  end

  ## HTML

  def html_clean(html)
    raw(ActionController::Base.helpers.sanitize(html, tags: SAFE_HTML_TAGS, attributes: %w(id class style href)).strip)
  end

  ## SITE

  def site_name
    'Qwiz Notes'
  end

  def site_owner
    'Banana Simplicity Inc.'
  end

  ## PAGE

  # Create a page title using I18n
  def page_meta(key = :title)
    return t("marketing.tagline") if current_page?(root_path) && !user_signed_in?
    action = action_name.sub(/create/, "new").sub(/update/, "edit")
    scope = "#{controller_path.tr "/", "."}.#{action}"
    translation = "#{scope}.#{key}"
    default_scopes = page_meta_default_scopes(translation: translation, scope: scope)
    t(translation, default_scopes)
  end

  # Default scope to compensate for Devise issues
  def page_meta_default_scopes(translation:, scope:)
    {
      default: [
        :"devise.#{translation}",
        :"#{scope}.title",
        :"devise.#{scope}.title",
        :"devise.#{translation.partition(".").last}",
        :"devise.#{scope.partition(".").last}.title"
      ],
      site_name: site_name,
      "#{controller_name.singularize}": controller_member_instance,
    }
  end
end
