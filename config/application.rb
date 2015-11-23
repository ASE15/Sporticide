require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

#Loading files to precompile
config.assets.precompile += ['jquery-ui.min.js', 'trainings.js']

#
# Hot fix for omniauth-facebook
#
module OmniAuth
  module Strategies
    class Facebook < OmniAuth::Strategies::OAuth2
      # NOTE If we're using code from the signed request then FB sets the redirect_uri to '' during the authorize
      # phase and it must match during the access_token phase:
      # https://github.com/facebook/facebook-php-sdk/blob/master/src/base_facebook.php#L477
      def callback_url
        if @authorization_code_from_signed_request_in_cookie
          ''
        else
          options[:callback_url] || (full_host + script_name + callback_path)
        end
      end
    end
  end
end

module Sporticide
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.initialize_on_precompile = false
  end
end
