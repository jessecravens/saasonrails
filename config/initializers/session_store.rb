# Be sure to restart your server when you modify this file.

#domain = %w(development test).include?(Rails.env) ? 'lvh.me' : 'saasonrails.herokuapp'

session_store_config_file = File.join Rails.root, 'config', 'session_details.yml'
raise "#{session_store_config_file} is missing!" unless File.exists? session_store_config_file
session_config = YAML.load_file(session_store_config_file)[Rails.env].symbolize_keys

MicrobizRails32MongoDevise::Application.config.session_store :cookie_store, key: '_microbiz-rails32-mongo-devise', domain: session_config[:subdomain]

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# MicrobizRails32MongoDevise::Application.config.session_store :active_record_store
