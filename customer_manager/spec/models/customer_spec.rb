require 'rails_helper'

describe 'Customer' do
	context 'validations' do
    let(:valid_customer) { build(:customer) }

	  it 'returns true for valid customer' do
	  	expect(valid_customer).to be_valid
	  end

	  it 'returns false without cnpj' do
	  	customer = Customer.new(corporate_name: 'Butter Beer', employees: 3)

	  	expect(customer).not_to be_valid
	  end

	  it 'returns false without corporate name' do
	  	customer = Customer.new(cnpj: 1521, employees: 3)

	  	expect(customer).not_to be_valid
	  end

	  it 'returns false for employees not as a number' do
	  	customer = Customer.new(cnpj: 1521, corporate_name: 'Butter Beer', employees: '34aD')

	  	expect(customer).not_to be_valid
	  end

	  it 'returns false without employees' do
	  	customer = Customer.new(cnpj: 1521, corporate_name: 'Butter Beer')

	  	expect(customer).not_to be_valid
	  end

	  it 'returns false for employees less than 2' do
	  	customer = Customer.new(cnpj: 1521, corporate_name: 'Butter Beer', employees: 1)

	  	expect(customer).not_to be_valid
	  end
	end

  context 'scopes' do
  	describe '.active' do
  		let!(:first_customer) { create(:customer, deleted: true) }
  		let!(:second_customer) { create(:customer) }
  		let!(:newest_customer) { create(:customer) }

		  it 'returns only active customers' do
		  	customers = Customer.active

	      expect(customers.present?).to eq true
		  	expect(customers).not_to include(first_customer)
		  end
		end
	end
end
