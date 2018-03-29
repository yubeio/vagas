require 'rails_helper'

RSpec.describe 'Client API', type: :request do
  let!(:clients) { create_list(:client, 10)}
  let(:client_id) { clients.first.id }

  describe 'GET /clients' do
    before { get '/clients'}

    it 'Retorna todos os clientes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'Http 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /Clients' do
    let(:valid_attributes) { { cnpj: '60.998.878/0001-90', razao_social: 'Cliente teste', total_employee: 20, total_process: 50 } }

    context 'Sucesso' do
      before { post '/clients', params: valid_attributes }

      it 'Cria um cliente' do
        expect(json['cnpj']).to eq('60.998.878/0001-90')
        expect(json['razao_social']).to eq('Cliente teste')
        expect(json['total_employee']).to eq(20)
        expect(json['total_process']).to eq(50)
        # expect(json['created_at']).to eq('2018-02-28 11:53:19000Z')
      end

      it 'Http status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Erro' do
      before { post '/clients', params: { cnpj: '60.998.878/0001-90', razao_social: 'Cliente teste', total_process: 50 } }

      it 'Http status 422' do
        expect(response).to have_http_status(422)
      end

      it 'Mensagem de erro' do
        expect(response.body)
        .to match(/Validation failed: Total employee can&#39;t be blank/)
      end
    end
  end

  describe 'PUT /clients/:id' do
    let(:valid_attributes) { { cnpj: '60.998.878/0001-90', razao_social: 'Cliente teste', total_employee: 20, total_process: 50 } }

    context 'Quando há cliente' do
      before { put "/clients/#{client_id}", params: valid_attributes }

      it 'Atualiza o cliente' do
        expect(response.body).to be_empty
      end

      it 'Http status 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /clients/:id' do
    before { delete "/clients/#{client_id}" }

    it 'Http status 204' do
      expect(response).to have_http_status(204)
    end
  end
end
