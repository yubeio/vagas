# frozen_string_literal: true

FactoryBot.define do
  factory :company_process do
    name Faker::Company.name
    description Faker::Company.name
    status 0
    association :company
  end
end
