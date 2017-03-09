ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "minitest/spec"
require "rspec/rails"
require "shoulda/matchers"
require "capybara/rails"
require "database_cleaner"
require "email_spec"
require "money-rails/test_helpers"
# require "pundit/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
types = %w(actions api decorators features helpers models policies services workers)
types.each do |type|
  path = "spec/#{type}/shared_examples/**/*.rb"
  Dir[Rails.root.join(path)].each { |file| require file }
end

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include AbstractController::Translation
  config.include ActiveJob::TestHelper
  config.include ControllerHelpers, type: :controller
  config.include Devise::TestHelpers, type: :controller
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include Rails.application.routes.url_helpers
  config.include Warden::Test::Helpers

  config.before :suite do
    Warden.test_mode!
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before :each do |example|
    ActionMailer::Base.deliveries.clear
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
    # FactoryGirl.lint
  end

  # Set this to false if you prefer not to run each of your examples within a transaction.
  config.use_transactional_fixtures = false

  # Infer spec type from file
  # Example: enabling you to call `get` and `post` in specs under `spec/controllers`.
  config.infer_spec_type_from_file_location!

  config.after :each do
    Warden.test_reset!
    DatabaseCleaner.clean
    reset_mailer
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
