source "https://rubygems.org"
source "https://rails-assets.org"

ruby "2.2.0"

gem "airbrake"
gem "bourbon"
gem "coffee-rails"
gem "delayed_job_active_record", "4.0.3"
gem "email_validator"
gem "flutie"
gem "high_voltage"
gem "jquery-rails"
gem "neat"
gem "bitters"
gem "pg"
gem "rack-timeout"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0.1"
gem "simple_form", "~> 3.1.0"
gem "title"
gem "uglifier"
gem "unicorn"
gem "devise", "~> 3.4.1"
gem "devise_invitable"
gem "apartment", "~> 0.26.0"
gem "pikaday-gem", "~> 1.1.0.0"
gem "momentjs-rails"
gem "gravatar_image_tag"
gem "hashtel", "~> 0.0.2"
gem "chart-js-rails"
gem "kaminari"
gem "select2-rails"
gem "http_accept_language"
gem "normalize-rails"
gem "rails-assets-chartjs", "~> 1.0.1.beta.4"
gem "twitter-text" # hashtag parsing
gem "jquery-atwho-rails", "~> 1.0.0" # autocomplete
gem "haml-rails"
gem "audited-activerecord", "~> 4.0"
gem "paperclip", "~> 4.2"
gem "redcarpet"
gem "dotenv-rails"
gem "foreman"
gem 'rubyzip'
gem 'zip-zip'
gem 'pundit'
# caching

gem "kgio" # faster I/O
gem "dalli" # memcached
gem "memcachier"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.0"
  gem "annotate"
  gem "brakeman"
  gem "letter_opener"
  gem "email_spec"
end

group :test do
  gem "capybara-webkit", ">= 1.0.0"
  gem "database_cleaner"
  gem "launchy"
  gem "shoulda-matchers", "~> 2.7.0"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "newrelic_rpm", ">= 3.7.3"
  gem "rails_12factor"
end

group :development do
  gem 'capistrano-rbenv', '~> 2.0', require: false
  gem 'capistrano-chruby', github: 'capistrano/chruby', require: false
  gem 'capistrano-bundler', '~> 1.1.3', require: false
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails', '~> 1.1'
end
