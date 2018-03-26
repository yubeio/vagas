require 'rails_helper'

describe 'RequestAuthorizationService' do
	let!(:admin) { create(:admin) }

	it 'returns nil for invalid token' do
		request_auth_service =
		  RequestAuthorizationService
		    .new({ "Authorization" => "invalid" })
		    .authorize

		expect(request_auth_service).to eq nil
	end

	it 'returns the client' do
		encoded_token =
		  JsonWebToken.encode(client_id: admin.id)

		request_auth_service =
		  RequestAuthorizationService
		    .new({ "Authorization" => encoded_token })
		    .authorize

		expect(request_auth_service).to eq admin
	end
end
