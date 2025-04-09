source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.6'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem "rack", ">= 2.2.0"

gem 'rails_admin', '~> 3.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/hotwired/turbo-rails
gem 'turbo-rails'
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'coffee-rails'
gem 'cssbundling-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '>= 0.4.0', group: :doc

gem 'angularjs-rails'

gem 'devise'
# Use ActiveModel has_secure_password
#gem 'bcrypt', '~> 3.1.7'

gem 'mongoid', github: 'mongodb/mongoid', branch: 'master'
gem 'kaminari-mongoid'
gem "mongoid-paperclip", :require => "mongoid_paperclip"

gem 'mimemagic', '~> 0.4.3'
gem 'sassc', '~> 2.1.0'
gem 'globalid', '>= 1.1.0'
gem 'net-smtp'

gem 'nokogiri', '~> 1.13'

gem 'concurrent-ruby', '1.3.4'
gem 'puma'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "factory_bot_rails"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'faker'
  gem 'capybara'
  gem 'webrick'
  gem 'selenium-webdriver'
  gem 'geckodriver-helper'
  gem 'capybara-screenshot'
end
