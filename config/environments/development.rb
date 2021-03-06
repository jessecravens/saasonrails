MicrobizRails32MongoDevise::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'lvh.me:3000' }
  config.action_mailer.delivery_method = :smtp
  
  #For MailCatcher
  config.action_mailer.smtp_settings = { address: "localhost", port: 1025 }
  # change to false to prevent email from being sent during development
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.serve_static_assets = true

  # Paperclip::Attachment.default_options.merge!({
  #   storage: :s3,
  #   bucket: ENV['S3_BUCKET_NAME'],
  #   path: "profile-avatars/:profile_id/:style/:filename",
  #   s3_credentials: { 
  #     access_key_id: ENV['S3_ACCESS_KEY_ID'], 
  #     secret_access_key: ENV['S3_SECRET_ACCESS_KEY'] 
  #   }
  # })

  Paperclip::Attachment.default_options.merge!(path: ":rails_root/public/system/profile-avatars/:profile_id/:style/:filename", url: "/system/profile-avatars/:profile_id/:style/:filename")
end
