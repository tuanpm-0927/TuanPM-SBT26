# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass", "3.3.7"
gem "bootstrap-will_paginate", "~> 1.0.0"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "mini_magick"
gem "pry"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.3"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "~> 3.1.7"
gem "ckeditor", github: "galetahub/ckeditor"
gem "chosen-rails"
gem 'bootstrap-wysihtml5-rails'
gem "chartjs-ror"
gem "groupdate"
gem "ransack"
gem "devise"
gem "figaro"
gem "omniauth-facebook"
gem "cancancan"
gem "social-share-button"
gem "chatwork"
gem "paranoia", "~> 2.2"
gem "paypal-express"
gem "font-awesome-rails"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 3.7"
  gem "rails-controller-testing"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "mysql2"
end

group :production do
  gem "pg"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
  gem "launchy"
  gem "shoulda-matchers", "~> 3.0", require: false
  gem "database_cleaner", "~> 1.5"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
