source 'https://rubygems.org'

gem 'rails', '3.2.3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do 
  gem "haml-rails", ">= 0.3.4"
  gem "rails-footnotes", ">= 3.7"
  gem "hpricot"
  gem "ruby_parser"
end

group :development, :test do 
  gem "rspec-rails", ">= 2.9.0.rc2"
  gem "factory_girl_rails", ">= 3.1.0"
  gem "pry-rails"
  gem "mailcatcher"
end

group :test do 
  gem "database_cleaner", ">= 0.7.2"
  gem "mongoid-rspec", ">= 1.4.4"
  gem "machinist"
  gem "email_spec", ">= 1.2.1"
  gem "cucumber-rails", ">= 1.3.0"
  gem "capybara", ">= 1.1.2"
  gem "launchy", ">= 2.1.0"
end

gem 'jquery-rails'
gem "haml", ">= 3.1.4"
gem 'less-rails'
gem "bson_ext", ">= 1.6.2"
gem "mongoid", ">= 2.4.8"
gem "devise", ">= 2.1.0.rc"
gem "simple_form"
gem "will_paginate", ">= 3.0.3"
gem "twitter-bootstrap-rails"
gem "heroku"
gem "cancan"
gem "rolify"

gem "mongoid-paperclip", require: "mongoid_paperclip"

# Only if we intend to use S3
# gem "aws-s3", require: "aws/s3"

# Facebook OAuth2 Strategy for OmniAuth
gem 'omniauth-facebook'

group :production do
  gem 'thin'
end
