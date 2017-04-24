require 'email_spec' # add this line if you use spork
require 'email_spec/cucumber'
require 'capybara-screenshot/cucumber'
require "cgi"

Capybara.javascript_driver = :webkit
Capybara.save_and_open_page_path = 'tmp/screenshots'

begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :truncation

rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

module Helper
   include ApplicationHelper
   include FactoryGirl::Syntax::Methods
   include ActionView::Helpers::SanitizeHelper

  def html_unescape(text)
    CGI.unescapeHTML(strip_tags(text))
  end

  def t(*args)
    I18n.t(*args)
  end

  # Fill in a tinyMCE textarea with content
  #
  # @param id [String]
  # @param opts [Hash]
  # @reference: https://gist.github.com/eoinkelly/69be6c27beb0106aa555
  #
  def fill_in_tinymce(id, opts)
    return unless opts[:with].present?
    # wait until the TinyMCE editor instance is ready
    sleep 0.5 until page.evaluate_script("tinyMCE.get('#{id}') !== null")

    page.execute_script <<-SCRIPT
      tinyMCE.get('#{id}').setContent('#{opts[:with]}');
    SCRIPT
  end

  # Fill in a CKEditor textarea with content
  #
  # @param locator [String]
  # @param opts [Hash]
  # @reference: http://stackoverflow.com/a/10957870/6615480
  #
  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json # convert to a safe javascript string
    using_wait_time 6 do
      page.execute_script <<-SCRIPT
        CKEDITOR.instances['#{locator}'].setData(#{content});
        $('textarea##{locator}').text(#{content});
      SCRIPT
    end
  end
end

World(Helper)

Transform(/^(-?\d+)$/) do |num|
  num.to_i
end

Before do
  DatabaseCleaner.start
end

# Before('@omniauth_test') do
#   OmniAuth.config.test_mode = true
#   Capybara.default_host = 'http://example.com'

#   OmniAuth.config.add_mock(:twitter, {
#     :uid => '12345',
#     :info => {
#       :name => 'twitteruser',
#     }
#   })

#   OmniAuth.config.add_mock(:facebook, {
#     :uid => '12345',
#     :info => {
#       :name => 'facebookuser'
#     }
#   })
# end

# After('@omniauth_test') do
#   OmniAuth.config.test_mode = false
# end

After do |scenario|
  DatabaseCleaner.clean
end
