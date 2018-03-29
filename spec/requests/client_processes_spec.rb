require 'rails_helper'

RSpec.describe 'ClientProcess API', type: :request do

  let!(:client) { create(:client) }
  let!(:client_process) { create_list(:client_process, 10, client_id: client.id) }
  let(:client_id) { client.id }
  let(:id) { client_process.first.id }

  describe 'GET - Processos dos clientes' do
    before { get "/clients/#{client_id}/client_processes" }

    it 'Retorna todos os processos do cliente' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'Http 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET Processo especifico' do
    before { get "/clients/#{client_id}/client_processes/#{id}" }

    context 'Quando processo existe' do
      it 'Http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna o processo' do
        expect(json['id']).to eq(id)
      end
    end

    context 'Quando processo não existe' do
      let(:id) { 0 }

      it 'Http status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST - Criar um processo' do
    let(:valid_attributes) { { name: 'Novo processo do cliente', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', process_status: 'rejeitado' } }

    context 'Processo valido e criar' do
      before { post "/clients/#{client_id}/client_processes/", params: valid_attributes }

      it 'Http status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Request invalido' do
      before { post "/clients/#{client_id}/client_processes/", params: {} }

      it 'Http status 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT - Atualizar processo do cliente' do
    let(:valid_attributes) { { name: 'Processo novo' } }

    before { put "/clients/#{client_id}/client_processes/#{id}", params: valid_attributes }

    context 'Quando existe um processo' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'Atualiza' do
        updated_item = ClientProcess.find(id)
        expect(updated_item.name).to match(/Processo novo/)
      end
    end

    context 'Quando não existe nenhum processo' do
      let(:id) { 0 }

      it 'Http status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE - Processos do cliente' do
    before { delete "/clients/#{client_id}/client_processes/#{id}" }

    it 'Http status 204' do
      expect(response).to have_http_status(204)
    end
  end
end
