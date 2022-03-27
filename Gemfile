source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Ruby on Rails
gem "rails", "~> 7.0.0"

# Assets
gem "sprockets-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"

# ActiveRecord
gem "pg", "~> 1.1"
gem "countries", "~> 4.2"
gem "credit_card_validations"

# Infrastructure
gem "puma", "~> 5.0"
gem "bootsnap", require: false

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# Redis
gem "redis", "~> 4.0"

# Timezone data
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# ActiveStorage
gem "image_processing"

# Schema validation
gem "json-schema"

group :development, :test do
  # Debugging
  gem "debug", platforms: %i[mri mingw x64_mingw]

  # Testing
  gem "rspec-rails"
  gem "capybara"
  gem "factory_bot_rails"
  gem "faker"
  gem "selenium-webdriver"
end

group :development do
  # Debugging
  gem "web-console"

  # Coding style
  gem "standardrb"
end
