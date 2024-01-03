source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false
gem "bcrypt"

# Use Sass to process CSS
# gem "sassc-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  #gem "sqlite3"
  gem "rspec-rails"
  gem 'factory_bot_rails'  
end

group :test do
  gem "database_cleaner"
  gem "launchy"
end

group :development do
  gem "web-console"
  gem "pg"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "shoulda-matchers"
end
