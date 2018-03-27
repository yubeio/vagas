require "rails_helper"

describe ApprovalProcessesController, type: :request do
  describe 'GET #index' do
    let!(:process) { create(:approval_process) }

    before do
      get '/approval_processes'

      @result = JSON.parse(response.body)
    end

    it 'return json with all processes' do
      expect(@result.first['name']).to eq(process.name)
    end

    it "retorna requisicao efetuada com sucesso" do
      expect(@response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let!(:client) { create(:yube_client) }

    it 'returns 201' do
      process_params = attributes_for(:approval_process, yube_client_id: client.id)

      post '/approval_processes', params: { approval_process: process_params }

      expect(response).to have_http_status(201)
    end
  end

  describe 'PATCH #update' do
    let!(:process) { create(:approval_process, name: 'Process xpto') }

    it 'returns 200' do
      process_params = attributes_for(:approval_process)

      patch "/approval_processes/#{process.id}", params: { approval_process: process_params }

      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    let!(:process) { create(:approval_process, name: 'Process xpto') }

    it 'returns 200' do
      delete "/approval_processes/#{process.id}"

      expect(response).to have_http_status(204)
    end
  end
end
