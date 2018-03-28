# README

# Installation

* Install Ruby 2.5.0
* Install Rails 5.1.5
* Install PostgreSQL 10.1
* Clone this project
* Run `bundle install` inside this project's directory
* Configure your PostgreSQL username and password on `config/database.yml`
* Run `bundle exec rails db:create`
* Run `bundle exec rails db:migrate && bundle exec rails db:migrate RAILS_ENV=test`
* Run `bundle exec rails db:seed`
* Run `bundle exec rspec .` to run all tests
* Run `bundle exec rails s` to get up your server

# Usage

* Create a client via terminal ou use the default admin client
* Send a POST to `/autenticate` with your client's username and password
* Copy and paste the generated token on your headers (`{ "Authorization": "#{token}" }` )
* You are free to make your requests now
