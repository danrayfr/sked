source "https://rubygems.org"

ruby file: ".ruby-version"

# Use main development branch of Rails
gem "rails", github: "rails/rails", branch: "8-0-stable"

# Drivers
gem "sqlite3", ">= 2.0"

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Deployment
gem "puma", ">= 5.0"
gem "kamal", require: false

# Frontend
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "propshaft"

# Other
gem "jbuilder"
gem "bootsnap", require: false
gem "bcrypt", "~> 3.1.7"
gem "image_processing", "~> 1.2"
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "tailwindcss-rails", "~> 3.1"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
