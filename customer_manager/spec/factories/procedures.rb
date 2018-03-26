FactoryBot.define do
	factory :procedure do
		name { Faker::StarWars.character }
		description { Faker::Lorem.paragraph }
		status Procedure::STATUS[:pending]
		customer_id nil
		deleted false
	end
end
