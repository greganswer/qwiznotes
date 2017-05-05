module ApplicationHelper
  include ActionView::Helpers::OutputSafetyHelper

  #
  # Constants
  #

  SAFE_HTML_TAGS = %w(
    a abbr acronym address area b bdo big blockquote br button caption center cite code col colgroup dd del dfn dir div dl dt em fieldset font form h1 h2 h3 h4 h5 h6 hr i img input ins kbd label legend li map mark menu ol optgroup option p pre q s samp select small span strike strong sub sup table tbody td textarea tfoot th thead u tr tt u ul var
  )

  #
  # HTML
  #

  def html_clean(html)
    options = { tags: SAFE_HTML_TAGS, attributes: %w(id class style href) }
    raw(ActionController::Base.helpers.sanitize(html, options)).strip
  end

  # This method belongs to `Kaminari` pagination gem but it is not working with
  # `searckick` gem for some reason. I copied it here and now it works
  # mysteriously.
  # @author: Greg Answer
  #
  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] || collection.entry_name.downcase
    entry_name = entry_name.pluralize unless collection.total_count == 1

    if collection.total_pages < 2
      t('helpers.page_entries_info.one_page.display_entries', :entry_name => entry_name, :count => collection.total_count)
    else
      first = collection.offset_value + 1
      last = collection.last_page? ? collection.total_count : collection.offset_value + collection.limit_value
      t('helpers.page_entries_info.more_pages.display_entries', :entry_name => entry_name, :first => first, :last => last, :total => collection.total_count)
    end.html_safe
  end

  #
  # Links
  #

  # If the URL is for the current page, set the URL to '#'. This way an 'a' tag is
  # displayed, which maintains page formating.
  # @see http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to
  #
  def link_to_hash_if_current(name = nil, options = nil, html_options = nil, &block)
    options = '#' if !block && options.present? && request.fullpath == url_for(options)
    name = '#' if block && name.present? && request.fullpath == url_for(name)
    link_to(name, options, html_options, &block)
  end

  def link_to_external_page(link)
    link_to raw("#{link} #{fa_icon "external-link"}"), link
  end

  #
  # Site
  #

  def site_email
    "support@qwiznotes.com"
  end

  def site_name
    "Qwiz Notes"
  end

  def site_owner
    "Greg Answer"
  end

  def site_owner_site
    "http://greganswer.com"
  end

  #
  # Page
  #

  # Check if the current page is one of the following pages that needs extra space:
  #   /notes/new
  #   /notes/:id/edit
  #
  def current_page_needs_more_space?
    url_for[/notes(?=.*(new|edit)).*/]
  end

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
