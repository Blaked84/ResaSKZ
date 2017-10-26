require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module LooklaDev
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :fr

    config.exception_handler = {
      dev:    false, # => defaults to "false" for dev mode. Set to true in production
      #db:     nil, # => defaults to :errors if true, else use "table_name" / :table_name
      #email: 	nil, # => requires string email and ActionMailer
      layouts: {
        # => nil inherits from ApplicationController
        # => 4xx errors should be nil
        # => 5xx errors should be "exception" but can be nil if explicitly defined
        500 => "exception",
        501 => "exception",
        502 => "exception",
        503 => "exception",
        504 => "exception",
        505 => "exception",
        507 => "exception",
        510 => "exception"
      }
    }
  end
end
