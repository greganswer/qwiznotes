source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "autoprefixer-rails"
gem "enumerize" # Enumerated attributes
gem "faker"
gem "haml-rails"
gem "kaminari" # Pagination gem
gem "local_time" # Time helper with javascript
gem "lograge" # Convert request logs to one line
gem "paranoia", "~> 2.2" # Adds soft deletion to models
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'jbuilder', '~> 2.5' # JSON builder
gem 'jquery-rails'
gem 'materialize-sass'
gem 'pg', '~> 0.18' # Postgresql
gem 'puma', '~> 3.0' # Puma server
gem "pundit" # Object oriented authorization
gem 'rails', '~> 5.0.2'
gem "ransack" # Object-based searching
gem 'redis', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem "factory_girl_rails" # Set up objects as test data
  gem "guard-rspec", require: false # Automated testing
  gem 'byebug', platform: :mri
end

group :development do
  # Capistrano for automatic deployment
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rbenv', '~> 2.1'
  # Additional
  gem "terminal-notifier-guard", "~> 1.6.1" # For OS X based notifications
  gem "better_errors" # Replaces the standard Rails error page
  gem "brakeman", require: false # Check for security vulnerabilities
  gem "bullet" # Warn about N+1 queries and unused eager loading
  gem "bundler-audit" # Checks for vulnerable versions of gems
  gem 'web-console', '>= 3.3.0' # In-page console window
  gem "meta_request" # RailsPanel is a Chrome extension
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "database_cleaner" # Cleans DB before/after tests
  gem "cucumber-rails", require: false # Code coverage for app
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
