class Api::V1::CustomersController < ApplicationController
	before_action :set_customer, only: [:show, :update, :destroy, :get_procedures]

	def index
		@customers = Customer.active

		render json: @customers, status: :ok
	end

	def show
		render json: @customer, status: :ok
	end

	def create
		@customer = Customer.new(customer_params)

		if @customer.save
			render json: @customer, status: :created
		else
			render_errors
		end
	end

	def update
		if @customer.update_attributes(customer_params)
			render json: @customer, status: :ok
		else
      render_errors
		end
	end

	def destroy
		if @customer.update_attributes(deleted: true)
			customer_procedures = @customer.procedures.active

			if customer_procedures.present?
			  Procedure.disable_procedures(customer_procedures)
			end

			head(:ok)
		else
			render_errors
		end
	end

	def get_procedures
		procedures = @customer.procedures.active

		render json: procedures, status: :ok
	end

	private

	def customer_params
		params.require(:customer).permit(:corporate_name, :cnpj, :employees)
	end

	def render_errors
		render json: { error: @customer.errors }, status: :unprocessable_entity
	end

	def set_customer
		@customer = Customer.where(id: params[:id], deleted: false).first

		if @customer.blank?
			return render json: { error: 'Customer not found' }, status: :unprocessable_entity
		end
	end
end
