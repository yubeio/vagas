class Api::V1::ProceduresController < ApplicationController
	before_action :set_procedure, only: [:show, :update, :destroy, :approve, :refuse]

	def index
		@procedures = Procedure.active

		render json: @procedures, status: :ok
	end

	def show
		render json: @procedure, status: :ok
	end

	def create
		@procedure = Procedure.new(procedure_params)

		if @procedure.save
			render json: @procedure, status: :created
		else
			render_errors
		end
	end

	def update
		if @procedure.update_attributes(procedure_params)
			render json: @procedure, status: :ok
		else
			render_errors
		end
	end

	def destroy
		if @procedure.update_attributes(deleted: true)
			head(:ok)
		else
			render_errors
		end
	end

	def approve
		if @procedure.update_attributes(status: Procedure::STATUS[:approved])
			render json: @procedure, status: :ok
		else
			render_errors
		end
	end

	def refuse
		if @procedure.update_attributes(status: Procedure::STATUS[:refused])
			render json: @procedure, status: :ok
		else
      render_errors
		end
	end

  private

  def set_procedure
    @procedure = Procedure.where(id: params[:id], deleted: false).first

    if @procedure.blank?
			return render json: { error: 'Procedure not found' }, status: :unprocessable_entity
		end
  end

  def render_errors
  	render json: { error: @procedure.errors }, status: :unprocessable_entity
  end

  def procedure_params
  	params.require(:procedure).permit(:name, :description, :customer_id)
  end
end
