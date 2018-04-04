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
      success_render('company_process.success.created')
    else
      failure_render('company_process.failure.created', @process)
    end
  end

  def update
    if @process.update_attributes(process_params)
      success_render('company_process.success.updated')
    else
      failure_render('company_process.failure.updated', @process)
    end
  end

  def update_status
    if @process.update_status(status_params) == true
      success_render('company_process.success.status_updated')
    else
      failure_render('company_process.failure.status_updated', @process)
    end
  end

  def destroy
    if @process.destroy
      success_render('company_process.success.deleted')
    else
      failure_render('company_process.failure.deleted', @process)
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def set_company_process
    @process = CompanyProcess.find(params[:id])
  end

  def process_params
    params.require(:company_process).permit(:name, :description)
  end

  def status_params
    params.require(:company_process).permit(:status)
  end
end
