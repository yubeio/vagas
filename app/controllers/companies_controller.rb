# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  def index
    render json: { companies: Company.all, status: :ok }
  end

  def index_with_deleted
    render json: { companies: Company.all_with_deleted.order(:status, :id), status: :ok }
  end

  def show
    render json: { company: @company, status: :ok }
  end

  def create
    company = Company.new(company_params)

    if company.save
      success_render('company.success.created')
    else
      failure_render('company.failure.created', company)
    end
  end

  def update
    if @company.update_attributes(company_params)
      success_render('company.success.updated')
    else
      failure_render('company.failure.updated', @company)
    end
  end

  def destroy
    @company.deleted!
    success_render('company.success.deleted')
  end

  private

  def set_company
      @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :employees_quantity, :cnpj)
  end
end
