require_relative 'boot'

require 'rails/all'
include ActionView::Helpers::NumberHelper

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Osem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 5.0

    config.active_record.observers = :revision_observer
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    # Errors raised within `after_rollback`/`after_commit` propagate normally
    # like in other Active Record callbacks.
    # config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :delayed_job
    config.autoloader = :classic
    config.autoload_paths << "#{Rails.root}/app/classes"
    config.exceptions_app = self.routes

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
