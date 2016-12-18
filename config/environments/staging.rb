Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The staging environment is used exclusively to run your application's
  # testing suite. You never need to work with it otherwise. Any feature that is
  # added to application will first deploy on this environement and then maybe
  # ported to the production environment.
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=3600'
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  
  config.default_email = "quinn@threadhabits.com"

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    :address              => ENV["smtp_address"],
    :port                 => "587",
    :domain               => ENV["smtp_domain"],
    :user_name            => ENV["smtp_username"],
    :password             => ENV["smtp_password"],
    :authentication       => 'plain'
  }

  config.action_mailer.default_url_options = { host: ENV["domain"] }
end
