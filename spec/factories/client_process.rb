FactoryBot.define do
  factory :client_process do
    name { Faker::Number.number(16) }
    description { Faker::Lorem.word }
    process_status 'pendente'
    client_id nil
  end
end
