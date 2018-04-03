FactoryBot.define do
  factory :company_process do
    name Faker::Company.name
    description Faker::Company.name
    status 0
    association :company
  end
end
