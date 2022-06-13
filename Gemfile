# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'bootsnap', require: false
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'sqlite3', '~> 1.4'
gem 'bcrypt', '~> 3.1.18'
gem 'jwt', '~> 2.4.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', '~> 1.30', require: false
  gem 'rubocop-rails', require: false
  gem 'rspec-rails', '~> 6.0.0.rc1'
end

group :development do
end
