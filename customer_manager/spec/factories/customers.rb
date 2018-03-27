FactoryBot.define do
  factory :customer do
    cnpj { Faker::Company.australian_business_number }
    corporate_name { Faker::Company.name }
    employees 3
    deleted false
  end
end
