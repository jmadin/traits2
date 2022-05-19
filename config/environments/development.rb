Traits::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false


  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :protocol => 'http', host: ENV['SITE_URL'] }

  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV['SITE_URL'],
    :enable_starttls_auto => true
  }

  # # specify what domain to use for mailer URLs

  #config.mandrill_mailer.default_url_options = { :host => 'localhost' }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # config.active_record.raise_in_transactional_callbacks = true

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # Google Analytics code
  # GA.tracker = "UA-51287714-1"
end

# MandrillMailer.configure do |config|
#   config.api_key = ENV['MANDRILL_API_KEY']
# end
