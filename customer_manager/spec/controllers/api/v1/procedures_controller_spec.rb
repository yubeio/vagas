require 'rails_helper'

RSpec.describe Api::V1::ProceduresController, type: :controller do
  let!(:client) { create(:client) }

  context 'authentication' do
    it 'authorizes client with valid token' do
      request.headers.merge!(auth_headers(client.username, client.password))

      get :index

      expect(response).to have_http_status(:ok)
    end

    it 'returns unauthorized for invalid token' do
      request.headers.merge!(auth_headers('invalid_username', 'superpass'))

      get :index

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'managing procedures' do
    let!(:customer) { create(:customer) }
    let!(:procedure_one) { create(:procedure, customer_id: customer.id) }
    let!(:procedure_two) { create(:procedure, customer_id: customer.id) }
    let!(:disabled_procedure) do
      create(
        :procedure,
        deleted: true,
        customer_id: customer.id
      )
    end

    before do
      request.headers.merge!(auth_headers(client.username, client.password))
    end

    describe 'GET #index' do
      let!(:other_customer) { create(:customer) }
      let!(:other_procedure) do
        create(:procedure, customer_id: other_customer.id)
      end

      it 'returns active procedures only' do
        get :index

        expect(response.body).to include(
          procedure_one.to_json,
          procedure_two.to_json,
          other_procedure.to_json
        )
        expect(response.body).not_to include(disabled_procedure.to_json)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'GET #show' do
      it 'returns the specific active procedure' do
        get :show, params: { id: procedure_one.id }

        expect(response.body).to include(procedure_one.to_json)
        expect(response).to have_http_status(:ok)
      end

      it 'returns procedure not found for disabled procedure' do
        get :show, params: { id: disabled_procedure.id }

        expect(response.body).not_to include(disabled_procedure.to_json)
        expect(response.body).to include('Procedure not found')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'POST #approve' do
      it "changes procedure' status to approved" do
        post :approve, params: { id: procedure_one.id }

        expect(procedure_one.reload.status).to eq Procedure::STATUS[:approved]
        expect(response).to have_http_status(:ok)
      end

      it 'returns procedure not found for disabled procedure' do
        post :approve, params: { id: disabled_procedure.id }

        expect(disabled_procedure.reload.status).not_to eq Procedure::STATUS[:approved]
        expect(response.body).to include('Procedure not found')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'POST #refuse' do
      it "changes procedure' status to refused" do
        post :refuse, params: { id: procedure_one.id }

        expect(procedure_one.reload.status).to eq Procedure::STATUS[:refused]
        expect(response).to have_http_status(:ok)
      end

      it 'returns procedure not found for disabled procedure' do
        post :refuse, params: { id: disabled_procedure.id }

        expect(disabled_procedure.reload.status).not_to eq Procedure::STATUS[:refused]
        expect(response.body).to include('Procedure not found')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'POST #destroy' do
      it "disables the procedure and updates customer's procedures count" do
        post :destroy, params: { id: procedure_one.id }

        expect(customer.reload.deleted).to eq false
        expect(customer.procedures_count).to eq 1
        expect(procedure_one.reload.deleted).to eq true
        expect(procedure_two.reload.deleted).to eq false
        expect(disabled_procedure.reload.deleted).to eq true
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'POST #create' do
      it 'creates a procedure' do
        customer = create(:customer)
        new_procedure = {
          name: Faker::StarWars.vehicle,
          description: Faker::StarWars.wookiee_sentence,
          customer_id: customer.id
        }

        post :create,  params: { procedure: new_procedure }

        expect(customer.reload.procedures_count).to eq 1
        expect(response.body).to include(new_procedure[:name])
        expect(response).to have_http_status(:created)
      end

      it 'returns errors for invalid procedure' do
        error_message = {
          error: {
            name: ["can't be blank"],
            customer: ['must exist']
          }
        }

        post(
          :create,
          params: {
            procedure: {
              name: '',
              description: 'Im invalid'
            }
          }
        )

        expect(response.body).to include(error_message.to_json)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'PATCH #update' do
      it 'updates an active procedure' do
        post(
          :update,
          params: {
            id: procedure_one.id,
            procedure: { name: 'edited_name' }
          }
        )

        expect(procedure_one.reload.name).to eq 'edited_name'
        expect(response).to have_http_status(:ok)
      end

      it 'returns errors for invalid params' do
        error_message = {
          error: {
            name: ["can't be blank"]
          }
        }

        post(
          :update,
          params: {
            id: procedure_one.id,
            procedure: {	name: '' }
          }
        )

        expect(response.body).to include(error_message.to_json)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update unpermitted params' do
        post(
          :update,
          params: {
            id: procedure_one.id,
            procedure: { deleted: true }
          }
        )

        expect(procedure_one.reload.deleted).not_to eq true
      end
    end
  end

  def auth_headers(username, password)
    token =
      ClientAuthenticationService
        .new(username, password)
        .encode_jwt

    {
      'Authorization': "#{token}"
    }
  end
end
