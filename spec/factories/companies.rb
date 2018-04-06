# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name Faker::Company.name
    cnpj Faker::CNPJ.unique.numeric
    employees_quantity 112
  end
end
