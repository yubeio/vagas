require 'rails_helper'
require 'byebug'

describe 'Client API' do

  let(:client_json) do
    {
      "clients":[{
        "client":{
          "cnpj": "89.101.576/0001-59",
          "company_name": "Company test",
          "officials_total" => 200
        }
      }]
    }
  end

  context 'POST /client' do
   it 'Create a new client' do
     post '/api/v1/client', params: client_json, headers: {}

     expect(response).to be_success
     expect(Client.all.count).to eql(1)
   end
  end

  context 'Patch /client' do
   it 'Update Client' do
     create(:client)
     change = { "client":{ "company_name": "Change Name" } }
     patch '/api/v1/client/1', params: change, headers: {}

     expect(response).to be_success
     expect(Client.all.first.company_name).to eql('Change Name')
   end
  end

  context 'Destroy /client' do
   it 'Delete Client' do
     create(:client)
     delete '/api/v1/client/1', params: {}, headers: {}

     expect(response).to be_success
     expect(Client.all.size).to eql(0)
   end

   it 'List destroyed clients' do
     client = create(:client)
     client.destroy
     get '/api/v1/deleted_clients/', params: {}, headers: {}
     json = JSON.parse(response.body)

     expect(response).to be_success
     expect(json.size).to eql(1)
     expect(json["clients"].first["id"]).to eql(1)

   end
  end

end
