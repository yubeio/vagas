require "rails_helper"

describe YubeClientsController, type: :request do
  describe 'GET #index' do
    let!(:client) { create(:yube_client) }

    before do
      get '/yube_clients'

      @result = JSON.parse(response.body)
    end

    it 'return json with all yube clients' do
      expect(@result.first['social_name']).to eq(client.social_name)
    end

    it "retorna requisicao efetuada com sucesso" do
      expect(@response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'returns 201' do
      client_params = attributes_for(:yube_client)

      post '/yube_clients', params: { yube_client: client_params }

      expect(response).to have_http_status(201)
    end
  end

  describe 'PATCH #update' do
    let!(:client) { create(:yube_client, social_name: 'Company xpto') }

    it 'returns 200' do
      client_params = attributes_for(:yube_client)

      patch "/yube_clients/#{client.id}", params: { yube_client: client_params }

      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    let!(:client) { create(:yube_client, social_name: 'Company xpto') }

    it 'returns 200' do
      delete "/yube_clients/#{client.id}"

      expect(response).to have_http_status(204)
    end
  end
end
