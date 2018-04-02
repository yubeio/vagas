class CompaniesController < ApplicationController
  def index
    render json: { companies: Company.json_all, status: :ok }
  end

  def show
    render json: { company: Company.where(id: params[:id]), status: :ok }
  end

  def create
    company = Company.new(company_params)
    if company.save
      render json: { message: I18n.t('company.created.success'), status: :ok }
    else
      render json: { message: I18n.t('company.created.failure'), status: :fail }
    end
  end

  def update
  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :employees_number,
                                    :cnpj, :processes_number)
  end
end
