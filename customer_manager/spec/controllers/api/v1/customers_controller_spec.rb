require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
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

  context 'managing customers' do
  	let!(:disabled_customer) { create(:customer, deleted: true) }
  	let!(:customer_without_procedures) { create(:customer) }
  	let!(:customer_with_procedures) { create(:customer) }

  	let!(:disabled_procedure) do
  		create(
  			:procedure,
  			deleted: true,
  			customer_id: customer_with_procedures.id
  		)
  	end
  	let!(:procedure_one) do
  		create(
  			:procedure,
  			customer_id: customer_with_procedures.id
  		)
  	end
  	let!(:procedure_two) do
  		create(
  			:procedure,
  			customer_id: customer_with_procedures.id
  		)
  	end

		before do
			request.headers.merge!(auth_headers(client.username, client.password))
		end

    describe 'GET #index' do
			it 'returns active customers only' do
				customer_with_procedures.reload
				get :index

				expect(response.body).to include(
					customer_without_procedures.to_json,
					customer_with_procedures.to_json
				)
				expect(response.body).not_to include(disabled_customer.to_json)
				expect(response).to have_http_status(:ok)
			end
		end

    describe 'GET #show' do
		  it 'returns the specific active customer' do
			  get :show, params: { id: customer_without_procedures.id }

			  expect(response.body).to include(customer_without_procedures.to_json)
			  expect(response).to have_http_status(:ok)
		  end

		  it 'returns customer not found for disabled customer' do
		  	get :show, params: { id: disabled_customer.id }

        expect(response.body).not_to include(disabled_customer.to_json)
		  	expect(response.body).to include('Customer not found')
		  	expect(response).to have_http_status(:unprocessable_entity)
		  end
	  end

	  describe 'GET #get_procedures' do
	  	it "returns the customer's active procedures" do
	  		get :get_procedures, params: { id: customer_with_procedures.id }

	  		expect(response.body).to include(
					procedure_one.to_json, procedure_two.to_json
				)
				expect(response.body).not_to include(disabled_procedure.to_json)
	  		expect(response).to have_http_status(:ok)
	  	end
	  end

	  describe 'POST #destroy' do
	  	it 'disables the customer and his actives procedures' do
	  		post :destroy, params: { id: customer_with_procedures.id }

	  		expect(customer_with_procedures.reload.deleted).to eq true
	  		expect(procedure_one.reload.deleted).to eq true
	  		expect(procedure_two.reload.deleted).to eq true
	  		expect(disabled_procedure.reload.deleted).to eq true
	  		expect(response).to have_http_status(:ok)
	  	end
	  end

	  describe 'POST #create' do
	  	it 'creates a customer' do
	  		new_customer = {
  				corporate_name: Faker::StarWars.planet,
  				cnpj: Faker::Number.number(10),
  				employees: 5
  		  }

	  		post :create,	params: { customer: new_customer }

        expect(response.body).to include(new_customer[:cnpj])
	  		expect(response).to have_http_status(:created)
	  	end

	  	it 'returns errors for invalid customer' do
	  		error_message = {
	  			error: {
	  				cnpj: ["can't be blank"],
	  				employees: ['is not a number']
	  			}
	  		}

	  		post(
	  			:create,
	  			params: {
	  				customer: {
	  					corporate_name: 'Im invalid',
	  					employees: 'Ah12'
	  				}
	  			}
	  		)

	  		expect(response.body).to include(error_message.to_json)
	  		expect(response).to have_http_status(:unprocessable_entity)
	  	end
	  end

	  describe 'POST #update' do
	  	it 'updates an active customer' do
	  		post(
	  			:update,
	  			params: {
	  				id: customer_without_procedures.id,
	  				customer: { corporate_name: 'edited_name'	}
	  			}
	  		)

        expect(customer_without_procedures.reload.corporate_name).to eq 'edited_name'
	  		expect(response).to have_http_status(:ok)
	  	end

	  	it 'returns errors for invalid params' do
	  		error_message = {
	  			error: {
	  				corporate_name: ["can't be blank"]
	  			}
	  		}

	  		post(
	  			:update,
	  			params: {
	  				id: customer_without_procedures.id,
	  				customer: {	corporate_name: '' }
	  			}
	  		)

	  		expect(response.body).to include(error_message.to_json)
	  		expect(response).to have_http_status(:unprocessable_entity)
	  	end

	  	it 'does not update unpermitted params' do
	  		post(
	  			:update,
	  			params: {
	  				id: customer_without_procedures.id,
	  				customer: {	deleted: true }
	  			}
	  		)

	  		expect(customer_without_procedures.reload.deleted).not_to eq true
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
