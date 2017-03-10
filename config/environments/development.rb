host_string = 'qwiznotes.dev'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

# Raise an error for unpermitted parameters.
  config.action_controller.action_on_unpermitted_parameters = :raise

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  ## ACTION MAILER

  config.action_mailer.default_url_options = { host: host_string }
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
  config.action_mailer.raise_delivery_errors = true

  ## BULLET - monitor and alert us of N+1 queries

  config.after_initialize do
    Bullet.rails_logger = true
    Bullet.add_footer = true
    Bullet.enable = false
    Bullet.bullet_logger = false
    Bullet.airbrake = false
    Bullet.console = false
    Bullet.alert = false
    Bullet.growl = false
  end

  ## GENERATORS

  config.generators do |generate|
    generate.helper false
    generate.skip_routes true
    generate.assets false
    generate.view_specs false
    generate.jbuilder false
    generate.test_framework :rspec, {
      request_specs: false,
      routing_specs: false,
      view_specs: false,
    }
  end
end

## ROUTES

Rails.application.routes.default_url_options = { host: host_string }
