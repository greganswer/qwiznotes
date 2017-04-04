Rails.application.configure do
  # Enable Lograge gem to convert request logs to one line.
  config.lograge.enabled = true

  # Allow Rails to search in locales subdirectories for additional files
  config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]

  # Do not swallow errors in after_commit/after_rollback callbacks.
  config.active_record.raise_in_transactional_callbacks = true

  # Background workers
  config.active_job.queue_adapter = :sidekiq
end

APP_CONFIG = {
  languages: {
    en: 'English',
    fr: 'Français'
  }
}
