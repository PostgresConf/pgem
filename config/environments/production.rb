Osem::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Set the secret_key_base from the env, if not set by any other means
  config.secret_key_base ||= ENV.fetch('SECRET_KEY_BASE', nil)

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "osem_#{Rails.env}"
  if config.respond_to?(:action_mailer)
      config.action_mailer.perform_caching = false
  end

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.action_mailer.default_url_options = { host: ENV.fetch('OSEM_HOSTNAME', 'localhost:3000') }
  config.action_mailer.smtp_settings = {
    address:              ENV.fetch('OSEM_SMTP_ADDRESS', 'localhost'),
    port:                 ENV.fetch('OSEM_SMTP_PORT', 25),
    user_name:            ENV.fetch('OSEM_SMTP_USERNAME', nil),
    password:             ENV.fetch('OSEM_SMTP_PASSWORD', nil),
    authentication:       ENV.fetch('OSEM_SMTP_AUTHENTICATION', 'plain').try(:to_sym),
    domain:               ENV.fetch('OSEM_SMTP_DOMAIN', nil),
    enable_starttls_auto: ENV.fetch('OSEM_SMTP_ENABLE_STARTTLS_AUTO', nil),
    openssl_verify_mode:  ENV.fetch('OSEM_SMTP_OPENSSL_VERIFY_MODE', nil)
  }.compact

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

# crash notifications
Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :deliver_with => :deliver, # Rails >= 4.2.1 do not need this option since it defaults to :deliver_now
    :email_prefix => "[EXCEPTION @ #{ENV['OSEM_HOSTNAME']}]",
    :sender_address => %{"OSEM Exceptions" <exceptions@postgresconf.org>},
    :exception_recipients => %w{websupport@postgresconf.org}
  }

end
