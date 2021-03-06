source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#postgresql
gem 'pg'
gem 'thin'

#authorization/authentication
gem 'devise'
gem 'cancan'

# WYSIWYG provided by tinymce
gem 'tinymce-rails'

# adding foreign keys
gem 'foreigner'
gem 'immigrant'

#gems for file upload and storage
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem 'carrierwave_direct'
gem 'sidekiq'

gem 'inherited_resources'



# Gems used only for assets and not required
# in production environments by default.
group :development do
  gem 'foreigner'
  gem 'immigrant'
  gem 'debugger'
  gem 'hirb'
  gem 'jist'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :test do
  gem "factory_girl_rails", "~> 4.0"
# adding 2.0.3 declaration may fix capybara-webkit issues
# per: http://stackoverflow.com/questions/15996969/capybara-webkit-page-should-have-content-not-implemented
  gem "capybara", "2.0.3"
 # gem "capybara-webkit"
  gem "guard-rspec"
  gem "launchy"
  gem "cucumber-rails"
  gem "database_cleaner"
  gem 'guard-cucumber'
end

group :development, :test do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rb-fsevent', '~> 0.9.1'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails'
  gem 'less-rails'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
