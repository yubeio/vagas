require 'rails_helper'
require 'byebug'

describe 'Client Process API' do

  let(:process_json) do
    {
    	"client_cnpj": "89.102.576/0001-59",
        "processes": [{
     	    "process":{
	           "name": "test process",
    	       "description": "Teste",
    	       "status": 'pendente'
    		  }
        }]
    }
  end

  context 'POST /client_process' do
   it 'Create a new process' do
     create(:client)
     post '/api/v1/client_process', params: process_json, headers: {}

     expect(response).to be_success
     expect(Client.all.first.process_total).to eql(1)
     expect(ClientProcess.all.count).to eql(1)
   end
  end

  context 'Patch /client_process' do
   it 'Update process' do
     create(:client)
     create(:client_process)
     change = { 'client_process':{'status':'aprovado' } }
     patch '/api/v1/client_process/1', params: change, headers: {}

     expect(response).to be_success
     expect(ClientProcess.all.first.status).to eql("aprovado")
   end
  end

  context 'Destroy /client_process' do
   it 'Delete process' do
     create(:client)
     create(:client_process)
     delete '/api/v1/client_process/1', params: {}, headers: {}

     expect(response).to be_success
     expect(ClientProcess.all.count).to eql(0)
   end
  end

end
