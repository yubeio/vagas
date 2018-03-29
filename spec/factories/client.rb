FactoryBot.define do
  factory :client do
    cnpj { Faker::Number.number(16) }
    razao_social { Faker::Lorem.word }
    total_employee { Faker::Number.number(3) }
    total_process { Faker::Number.number(2) }
  end
end
