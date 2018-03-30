class ClientProcessesController < ApplicationController
  before_action :set_client
  before_action :set_client_process, only: [:show, :update, :destroy]

  def index
    json_response(@client.ClientProcess)
  end

  def create
    @client.ClientProcess.create!(client_process_params)
    json_response(@client_process, :created)
  end

  def show
    json_response(@client_process)
  end

  def update
    @client_process.update(client_process_params)
    head :no_content
  end

  def destroy
    @client_process.update(:disabled => true)
    head :no_content
  end

  private
  def client_process_params
    params.permit(:name, :description, :process_status)
  end

  def set_client
    @client = Client.find params[:client_id]
  end

  def set_client_process
    @client_process = @client.ClientProcess.find_by!(id: params[:id]) if @client
  end
end
