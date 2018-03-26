FactoryBot.define do
  factory :client do
		username { Faker::Pokemon.name }
		domain 'www.customer_manager.com'
		password { Faker::Number.hexadecimal(10) }
	end

	factory :admin, class: Client do
		username 'admin'
		domain 'www.customer_manager.com'
		password 'Hj09aSkx'
	end
end
