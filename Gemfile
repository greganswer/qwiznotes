source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.2', '>= 4.2.1'
gem 'devise', '>= 4.2.0'
gem 'enumerize'
gem 'font-awesome-rails', '>= 4.7.0.1'
gem 'gretel', '>= 3.0.9'
gem 'haml-rails', '>= 0.9.0'
gem 'hashids'
gem 'jquery-rails', '>= 4.2.2'
gem 'kaminari'
gem 'local_time', '>= 1.0.3'
gem 'lograge', '>= 0.4.1'
gem 'mail_form', '>= 1.6.0'
gem 'material_icons', '>= 2.2.1'
gem 'materialize-sass'
gem 'paranoia', '~> 2.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'pundit'
gem 'rails', '~> 5.0.2'
gem 'ransack', '>= 1.8.2'
gem 'redis', '~> 3.0'
gem 'roadie', '~> 3.1.1'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'sidekiq', '>= 4.2.9'
gem 'simple_form', '>= 3.4.0'
gem 'tinymce-rails', '>= 4.5.6'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier', '>= 1.3.0'

group :development, :test, :staging do
  gem 'factory_girl_rails', '>= 4.8.0'
  gem 'faker'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'cucumber-rails', '>= 1.4.5', require: false
  gem 'guard-cucumber'
  gem 'guard-rspec', require: false
  gem 'i18n-tasks', '~> 0.9.12'
  gem 'letter_opener'
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

group :development do
  gem "binding_of_caller"
  gem 'better_errors', '>= 2.1.1'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit'
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'listen', '~> 3.0.5'
  gem 'meta_request', '>= 0.4.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.4.0'
end

group :test do
  gem 'capybara-webkit', '>= 1.12.0'
  gem 'capybara-screenshot', '>= 1.0.14'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

# Annotations
# Open links in Atom text editor -> Place cursor in the link and pres CTRL-SHIFT-O
#-----------------------------------------------------------------------------------------------------------
#
# autoprefixer-rails -> Parse CSS and add vendor prefixes
# https://github.com/ai/autoprefixer-rails
#
# better_errors -> Replaces the standard Rails error page
# https://github.com/charliesome/better_errors
#
# binding_of_caller -> Grab bindings from higher up the call stack and evaluate code in that context
# https://github.com/banister/binding_of_caller
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
# byebug -> Ruby debugger
# https://github.com/deivid-rodriguez/byebug
#
# capistrano -> Automated deployment scripts
# https://github.com/capistrano/capistrano
#
# capistrano-passenger -> Passenger support for Capistrano 3.x
# https://github.com/capistrano/passenger
#
# capistrano-rails -> Ruby on Rails specific tasks for Capistrano
# https://github.com/capistrano/rails
#
# capistrano-rbenv -> Idiomatic rbenv support for Capistrano 3.x
# https://github.com/capistrano/rbenv
#
# capybara-screenshot -> Automatically save screen shots when a Capybara scenario fails
# https://github.com/mattheworiordan/capybara-screenshot
#
# capybara-webkit -> Capybara driver for headless WebKit to test JavaScript
# https://github.com/thoughtbot/capybara-webkit
#
# ckeditor -> WYSIWYG text editor
# https://github.com/galetahub/ckeditor
#
# coffee-rails -> CoffeeScript adapter for Rails
# https://github.com/rails/coffee-rails
#
# cucumber-rails -> Rails Generators for Cucumber feature testing framework
# https://github.com/cucumber/cucumber-rails
#
# database_cleaner -> Cleans DB before/after tests
# https://github.com/DatabaseCleaner/database_cleaner
#
# devise -> User authentication solution
# https://github.com/plataformatec/devise
#
# email_spec -> Rspec email matchers
# https://github.com/email-spec/email-spec
#
# enumerize -> Enumerated attributes
# https://github.com/brainspec/enumerize
#
# factory_girl_rails -> Set up objects as test data
# https://github.com/thoughtbot/factory_girl_rails
#
# faker -> Fake data generator
# https://github.com/stympy/faker
#
# gretel -> Flexible Ruby on Rails breadcrumbs plugin.
# https://github.com/lassebunk/gretel
#
# guard-cucumber -> Automated feature testing
# https://github.com/guard/guard-cucumber
#
# guard-rspec -> Automated unit/feature testing
# https://github.com/guard/guard-rspec
#
# haml-rails -> Haml generators for Rails
# https://github.com/indirect/haml-rails
#
# hashids -> generate YouTube-like hashes from one or many numbers
# https://github.com/peterhellberg/hashids.rb
#
# i18n-tasks -> Manage translation and localization
# https://github.com/glebm/i18n-tasks
#
# jquery-rails -> jQuery for Rails
# https://github.com/rails/jquery-rails
#
# kaminari -> Pagination
# https://github.com/kaminari/kaminari
#
# launchy -> Launch the current view in browser/image
# https://github.com/copiousfreetime/launchy
#
# letter_opener -> Preview email in browser instead of sending it
# https://github.com/ryanb/letter_opener
#
# listen -> Listens to file modifications and notifies you about the changes
# https://github.com/guard/listen
#
# local_time -> Rails engine for cache-friendly, client-side local time
# https://github.com/basecamp/local_time
#
# lograge -> Minimize Rails' default request logging
# https://github.com/roidrage/lograge
#
# mail_form -> Send e-mail straight from forms
# https://github.com/plataformatec/mail_form
#
# material_icons -> Google Material Design Icons Rails wrapper
# https://github.com/Angelmmiguel/material_icons
#
# materialize-sass -> Google Material Design SCSS
# https://github.com/mkhairi/materialize-sass
#
# meta_request -> RailsPanel is a Chrome extension
# https://github.com/dejan/rails_panel
#
# paranoia -> Adds soft deletion to models
# https://github.com/rubysherpas/paranoia
#
# pg -> PostgreSQL RDBMS
# https://bitbucket.org/ged/ruby-pg/wiki/Home
#
# puma -> A ruby web server built for concurrency
# https://github.com/puma/puma
#
# pundit -> Minimal authorization through OO design and pure Ruby classes
# https://github.com/elabs/pundit
#
# rails -> Ruby on Rails web framework
# https://github.com/rails/rails
#
# ransack -> Object-based searching.
# https://github.com/activerecord-hackery/ransack
#
# redis -> A Ruby client library for Redis
# https://github.com/redis/redis-rb
#
# roadie -> Making HTML emails comfortable for Ruby
# https://github.com/Mange/roadie
#
# rspec-rails -> Rails integration for Rspec testing framework
# https://github.com/rspec/rspec-rails
#
# sass-rails -> Official Ruby-on-Rails Integration with Sass
# https://github.com/rails/sass-rails
#
# searchkick -> Rails search with Elasticsearch
# https://github.com/ankane/searchkick
#
# shoulda-matchers -> Rspec one-line test matchers
# https://github.com/thoughtbot/shoulda-matchers
#
# sidekiq -> background processing for Ruby
# https://github.com/mperham/sidekiq
#
# simple_form -> Simplified form DSL
# https://github.com/plataformatec/simple_form
#
# spring -> Rails application preloader
# https://github.com/rails/spring
#
# spring-commands-cucumber -> Implement the Cucumber command for Spring.
# https://github.com/jonleighton/spring-commands-cucumber
#
# spring-commands-rspec -> Implement the Rspec command for Spring.
# https://github.com/jonleighton/spring-commands-rspec
# spring-watcher-listen -> Make Spring watch the filesystem for changes using Listen rather than by polling the filesystem.
# https://github.com/jonleighton/spring-watcher-listen
#
# terminal-notifier-guard -> Mac OS X User Notifications for Guard
# https://github.com/Codaisseur/terminal-notifier-guard
#
# tinymce-rails -> TinyMCE WYSIWYG editor
# https://github.com/spohlenz/tinymce-rails
#
# tzinfo-data -> Include Timezone zoneinfo files for Windows operating system
# https://github.com/tzinfo/tzinfo-data
#
# uglifier -> UglifyJS JavaScript compressor
# https://github.com/lautis/uglifier
#
# web-console -> In-page console window
# https://github.com/rails/web-console
