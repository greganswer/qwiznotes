module ApplicationHelper
  include ActionView::Helpers::OutputSafetyHelper

  #
  # Constants
  #

  SAFE_HTML_TAGS = %w(
    a abbr acronym address area b bdo big blockquote br button caption center cite code col colgroup dd del dfn dir div dl dt em fieldset font form h1 h2 h3 h4 h5 h6 hr i img input ins kbd label legend li map mark menu ol optgroup option p pre q s samp select small span strike strong sub sup table tbody td textarea tfoot th thead u tr tt u ul var
  )

  #
  # Controller
  #

  def controller_collection_instance
    instance_variable_get("@#{controller_name}")
  end

  def controller_member_instance
    instance_variable_get("@#{controller_name}".singularize)
  end

  #
  # HTML
  #

  def html_clean(html)
    raw(ActionController::Base.helpers.sanitize(html, tags: SAFE_HTML_TAGS, attributes: %w(id class style href)).strip)
  end

  #
  # Links
  #

  # If the URL is for the current page, set the URL to '#'. This way an 'a' tag is displayed, which maintains page formating

  def link_to_hash_if_current(name = nil, options = nil, html_options = nil, &block)
    options = '#' if !block && options.present? && request.fullpath == options
    name = '#' if block && name.present? && request.fullpath == name
    link_to(name, options, html_options, &block)
  end

  #
  # Site
  #

  def site_name
    'Qwiz Notes'
  end

  def site_owner
    'Banana Simplicity Inc.'
  end

  #
  # Page
  #

  def page_title(text)
    content_for :title, text
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text = "")
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end
end
