# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'active_model_serializers', '~> 0.10.13'
gem 'aws-sdk-s3', '~> 1.114'
gem 'bcrypt', '~> 3.1.18'
gem 'bootsnap', require: false
gem 'jwt', '~> 2.4.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'rswag', '~> 2.5.1'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'rubocop', '~> 1.30', require: false
  gem 'rubocop-rails', require: false
end

group :development do
end
