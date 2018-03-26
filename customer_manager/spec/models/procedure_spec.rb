require 'rails_helper'

describe 'Procedure' do
	let!(:customer) { create(:customer) }

	context 'validations' do
    let(:valid_procedure) { create(:procedure, customer_id: customer.id) }

	  it 'returns true for valid procedure' do
	  	expect(valid_procedure).to be_valid
	  end

	  it 'returns false without customer' do
      procedure = Procedure.new(name: 'Test procedure')

	  	expect(procedure).not_to be_valid
	  end

	  it 'returns false without name' do
	  	procedure = Procedure.new(customer_id: customer.id)

	  	expect(procedure).not_to be_valid
	  end
	end

  context 'scopes' do
  	describe '.active' do
  		let!(:first_procedure) { create(:procedure, customer_id: customer.id) }
  		let!(:second_procedure) { create(:procedure, customer_id: customer.id) }
  		let!(:disabled_procedure) do
  			procedure = create(
  				:procedure,
  				deleted: true,
  				customer_id: customer.id
  			)
  		end

		  it 'returns only active procedures' do
		  	procedures = Procedure.active

	      expect(procedures.present?).to eq true
		  	expect(procedures).not_to include(disabled_procedure)
		  end
	  end
	end

	describe '#disable_procedures' do
		let!(:other_customer) { create(:customer) }
		let!(:procedure_one) { create(:procedure, customer_id: other_customer.id) }
		let!(:procedure_two) { create(:procedure, customer_id: other_customer.id) }
		let!(:enabled_procedure) { create(:procedure, customer_id: customer.id) }

		it 'disable the given procedures' do
      Procedure.disable_procedures(other_customer.procedures)

      expect(Procedure.active).to include(enabled_procedure)
      expect(Procedure.active).not_to include([procedure_one, procedure_two])
		end
	end

	context 'updating deleted attribute' do
		let!(:procedure_one) { create(:procedure, customer_id: customer.id) }
		let!(:procedure_two) { create(:procedure, customer_id: customer.id) }
    let!(:disabled_procedure) { create(:procedure, customer_id: customer.id, deleted: true) }

		it "adds one to customer's procedure count for reactivated procedure" do
			disabled_procedure.update_attributes(deleted: false)

			expect(customer.reload.procedures_count).to eq 3
		end

		it "subtracts one to customer's procedure count for disabled procedure" do
			procedure_one.update_attributes(deleted: true)

			expect(customer.reload.procedures_count).to eq 1
		end

		it "adds one to customer's procedures count for new created procedure" do
			new_procedure = create(:procedure, customer_id: customer.id)

			expect(customer.reload.procedures_count).to eq 3
		end

		it "does not add one to customer's count for procedures created as disabled" do
			disabled_new_procedure = create(:procedure, customer_id: customer.id, deleted: true)

			expect(customer.reload.procedures_count).to eq 2
		end
	end
end
