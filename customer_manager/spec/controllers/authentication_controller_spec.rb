require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #authenticate' do
    let!(:client) { create(:client) }

    it 'returns the authentication token' do
      params = {
        'client': {
          'username': client.username,
          'password': client.password
        }
      }

      post :authenticate, params: params
      hash_body = JSON.parse(response.body).with_indifferent_access

      expect(response).to have_http_status(:ok)
      expect(hash_body["auth_token"].present?).to eq true
    end

    it 'returns unauthorized for invalid credentials' do
      params = {
        'client': {
          'username': 'invalid_username',
          'password': 'invalid_password'
        }
      }

      post :authenticate, params: params

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
