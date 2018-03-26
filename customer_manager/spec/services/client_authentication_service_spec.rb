require 'rails_helper'

describe 'ClientAuthenticationService' do
	let!(:admin) { create(:admin) }

	it 'returns nil for invalid client' do
		auth_service =
      ClientAuthenticationService.
        new('iminvalid', 'meeither')
        .encode_jwt

    expect(auth_service).to eq nil
	end

	it 'returns encoded jwt' do
    auth_service =
      ClientAuthenticationService.
        new(admin.username, admin.password)
        .encode_jwt

    expect(auth_service).not_to eq nil
	end
end
