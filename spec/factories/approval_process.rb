FactoryBot.define do
  factory :approval_process do
    name 'admissão'
    description 'processo com uma descrição extensa'
    status 'pendente'
    yube_client
  end
end
