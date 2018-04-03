# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name Faker::Company.name
    cnpj Faker::CNPJ.unique.numeric
    employees_number 112
    processes_number 12
  end
end
