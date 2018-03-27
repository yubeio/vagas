Customer.delete_all && Procedure.delete_all && Client.delete_all

Client.create!(username: 'admin', password: 'master_pass')

3.times do
  Customer.create!(
    corporate_name: Faker::BackToTheFuture.character,
    employees: Faker::Number.between(2, 10000),
    cnpj: Faker::Number.number(10)
  )
end

Customer.create!(
  corporate_name: Faker::BackToTheFuture.character,
  employees: Faker::Number.between(2, 10000),
  cnpj: Faker::Number.number(10),
  deleted: true
)

5.times do
  Procedure.create!(
    name: Faker::BossaNova.song,
    description: Faker::Lorem.sentence,
    customer_id: Customer.first.id
  )
end

Procedure.create!(
  name: Faker::BossaNova.song,
  description: Faker::Lorem.sentence,
  customer_id: Customer.first.id,
  deleted: true
)
