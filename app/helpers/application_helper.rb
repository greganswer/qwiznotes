module ApplicationHelper
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
    return t("marketing.tagline") if current_page?(root_path) #&& !user_signed_in?
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
