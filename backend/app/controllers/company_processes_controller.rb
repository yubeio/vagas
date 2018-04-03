class CompanyProcessesController < ApplicationController
  before_action :set_company_process, only: %i[show update destroy update_status]
  before_action :set_company, only: %i[index create]

  def index
    render json: { processes: @company.company_processes, status: :ok }
  end

  def show
    render json: { processes: @process, status: :ok }
  end

  def create
    @process = @company.company_processes.build(process_params)

    if @process.save
      render json: { message: I18n.t('company_process.success.created'), status: :ok }
    else
      render json: { message: I18n.t('company_process.failure.created'),
                     details: @process.errors.full_messages, status: :bad_request }
    end
  end

  def update
    if @process.update_attributes(process_params)
      render json: { message: I18n.t('company_process.success.updated'), status: :ok }
    else
      render json: { message: I18n.t('company_process.failure.updated'), status: :bad_request }
    end
  end

  def update_status
    if @process.update_status(status_params) == true
      render json: { message: I18n.t('company_process.success.status_updated'), status: :ok }
    else
      render json: { message: I18n.t('company_process.failure.status_updated'), status: :bad_request }
    end
  end

  def destroy
    if @process.destroy
      render json: { message: I18n.t('company_process.success.deleted'), status: :ok }
    else
      render json: { message: I18n.t('company_process.failure.deleted'), status: :bad_request }
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: I18n.t('company.errors.not_found'), status: :not_found }
  end

  def set_company_process
    @process = CompanyProcess.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render(json: { message: I18n.t('company_process.errors.not_found'), status: :not_found }) && (return)
  end

  def process_params
    params.permit(:name, :description)
  end

  def status_params
    params.permit(:status)
  end
end
