[![Build Status](https://semaphoreci.com/api/v1/vinylimaz/vagas/branches/master/badge.svg)](https://semaphoreci.com/vinylimaz/vagas)
![Coverage](backend/coverage/coverage.svg "coverage")

## What are all this shit?

  Hello guys, I'm Vinicius and this is my solution to the problem that you
brought to me :D

## Versions
* Ruby version
2.4.3
* Rails version
5.1.6

# How to?

- First `bundle install`
- Second `rails db:create db:migrate`
- Third `rspec`
- Fourth `rails s`

## A little explanation about my solution:

To solve this problem I used rails-api;
I created 2 endpoints of create/update/show etc for 2 models;

A `Company` has_many `CompanyProcess`

For the *delete* problem, my solution consist in a `enum` with 2 values:
`active, deleted`, all models are created with `active` and can be `deleted`,
like all models can be `deleted` and turn `active` like magic;
The `enum` brings somes facilities, like: change status with `#status!`, e.g.
`#accepted!`, predicate methods: `deleted?` and encapsulate magic numbers;

To validate CNPJ I used gem: `cpf_cnpj`;

The `Company` model has a `:default_scope` to show only `active` and has a scope
`all_with_deleted` to return ALL companies;

The `CompanyProcess` has a action and a method to update its status: `#update_status`;

I created 2 helpers for controllers, to DRY some things:

`render_helper`: To render success or failures

`exception_helper`: To catch exceptions and render a specific json;
