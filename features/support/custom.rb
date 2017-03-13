require 'email_spec' # add this line if you use spork
require 'email_spec/cucumber'
require 'capybara-screenshot/cucumber'

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
