source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'enumerize' # Enumerated attributes
gem 'faker'
gem 'gretel'
gem 'haml-rails'
gem 'hashids' # YouTube-like hashes from one or many numbers
gem 'jbuilder', '~> 2.5' # JSON builder
gem 'jquery-rails'
gem 'kaminari' # Pagination gem
gem 'local_time' # Time helper with javascript
gem 'lograge' # Convert request logs to one line
gem 'material_icons'
gem 'materialize-sass'
gem 'paranoia', '~> 2.2' # Adds soft deletion to models
gem 'pg', '~> 0.18' # Postgresql
gem 'puma', '~> 3.0' # Puma server
gem 'pundit' # Object oriented authorization
gem 'rails', '~> 5.0.2'
gem 'ransack' # Object-based searching
gem 'redis', '~> 3.0'
gem 'roadie', '~> 3.1.1' # Inline CSS for mailers
gem 'sass-rails', '~> 5.0'
gem "sidekiq" # Background processing
gem 'simple_form'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier', '>= 1.3.0'

# Capistrano for automatic deployment
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1'

group :development, :test, :staging do
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'cucumber-rails', require: false
  gem 'guard-cucumber'
  gem 'guard-rspec', require: false
  gem 'i18n-tasks', '~> 0.9.12'
  gem 'letter_opener'
  gem 'rspec-rails', '~> 3.5'
  gem 'terminal-notifier-guard', '~> 1.6.1'
end

group :development do
  gem 'better_errors'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit'
  gem 'listen', '~> 3.0.5'
  gem 'meta_request'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

# Annotations
# Open links in Sublime text editor -> Right click the link
# Open links in Atom text editor -> Place cursor in the link and pres CTRL-SHIFT-O
#
# acts-as-taggable-on -> A tagging plugin
# https://github.com/mbleigh/acts-as-taggable-on
#
# autoprefixer-rails -> Parse CSS and add vendor prefixes
# https://github.com/ai/autoprefixer-rails
#
# coffee-rails -> CoffeeScript adapter for Rails
# https://github.com/rails/coffee-rails
#
# devise -> User authentication solution
# https://github.com/plataformatec/devise
#
# haml-rails -> Haml generators for Rails
# https://github.com/indirect/haml-rails
#
# jquery-rails -> jQuery for Rails
# https://github.com/rails/jquery-rails
#
# kaminari -> Pagination
# https://github.com/kaminari/kaminari
#
# lograge -> Minimize Rails' default request logging
# https://github.com/roidrage/lograge
#
# material_icons -> Google Material Design Icons Rails wrapper
# https://github.com/Angelmmiguel/material_icons
#
# materialize-sass -> Google Material Design SCSS
# https://github.com/mkhairi/materialize-sass
#
# pg -> PostgreSQL RDBMS
# https://bitbucket.org/ged/ruby-pg/wiki/Home
#
# puma -> A ruby web server built for concurrency
# https://github.com/puma/puma
#
# rails -> Ruby on Rails web framework
# https://github.com/rails/rails
#
# sass-rails -> Official Ruby-on-Rails Integration with Sass
# https://github.com/rails/sass-rails
#
# simple_form -> Simplified form DSL
# https://github.com/plataformatec/simple_form
#
# tzinfo-data -> Include Timezone zoneinfo files for Windows operating system
# https://github.com/tzinfo/tzinfo-data
#
# uglifier -> UglifyJS JavaScript compressor
# https://github.com/lautis/uglifier
#
# factory_girl_rails -> Set up objects as test data
# https://github.com/thoughtbot/factory_girl_rails
#
# faker -> Fake data generator
# https://github.com/stympy/faker
#
# byebug -> Ruby debugger
# https://github.com/deivid-rodriguez/byebug
#
# cucumber-rails -> Rails Generators for Cucumber feature testing framework
# https://github.com/cucumber/cucumber-rails
#
# guard-cucumber -> Automated feature testing
# https://github.com/guard/guard-cucumber
#
# guard-rspec -> Automated unit/feature testing
# https://github.com/guard/guard-rspec
#
# i18n-tasks -> Manage translation and localization
# https://github.com/glebm/i18n-tasks
#
# letter_opener -> Preview email in browser instead of sending it
# https://github.com/ryanb/letter_opener
#
# rspec-rails -> Rails integration for Rspec testing framework
# https://github.com/rspec/rspec-rails
#
# terminal-notifier-guard -> Mac OS X User Notifications for Guard
# https://github.com/Codaisseur/terminal-notifier-guard
#
# better_errors -> Replaces the standard Rails error page
# https://github.com/charliesome/better_errors
#
# brakeman -> Check for security vulnerabilities
# https://github.com/presidentbeef/brakeman
#
# bullet -> Warn about N+1 queries and unused eager loading
# https://github.com/flyerhzm/bullet
#
# bundler-audit -> Checks for vulnerable versions of gems
# https://github.com/rubysec/bundler-audit
#
# listen -> Listens to file modifications and notifies you about the changes
# https://github.com/guard/listen
#
# meta_request -> RailsPanel is a Chrome extension
# https://github.com/dejan/rails_panel
#
# spring -> Rails application preloader
# https://github.com/rails/spring
#
# spring-watcher-listen -> Make Spring watch the filesystem for changes using Listen rather than by polling the filesystem.
# https://github.com/jonleighton/spring-watcher-listen
#
# web-console -> In-page console window
# https://github.com/rails/web-console
#
# capybara-webkit -> Capybara driver for headless WebKit to test JavaScript
# https://github.com/thoughtbot/capybara-webkit
#
# capybara-screenshot -> Automatically save screen shots when a Capybara scenario fails
# https://github.com/mattheworiordan/capybara-screenshot
#
# database_cleaner -> Cleans DB before/after tests
# https://github.com/DatabaseCleaner/database_cleaner
#
# email_spec -> Rspec email matchers
# https://github.com/email-spec/email-spec
#
# launchy -> Launch the current view in browser/image
# https://github.com/copiousfreetime/launchy
#
# shoulda-matchers -> Rspec one-line test matchers
# https://github.com/thoughtbot/shoulda-matchers
#
# spring-commands-cucumber -> Implement the Cucumber command for Spring.
# https://github.com/jonleighton/spring-commands-cucumber
#
# spring-commands-rspec -> Implement the Rspec command for Spring.
# https://github.com/jonleighton/spring-commands-rspec

