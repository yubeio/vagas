source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.5'
gem 'puma', '~> 3.7'
gem 'mysql2', '~> 0.4.4'

group :development do
  gem 'capistrano'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1'
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'database_cleaner'
end
