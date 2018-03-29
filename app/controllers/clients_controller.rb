class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  def index
    @clients = Client.all
    json_response @clients
  end

  def create
    @client = Client.create!(client_params)
    json_response(@client, :created)
  end

  def show
    json_response(@client)
  end

  def update
    @client.update(client_params)
    head :no_content
  end

  def destroy
    @client.destroy
    head :no_content
  end

  private
  def client_params
    params.permit(:cnpj, :razao_social, :total_employee, :total_process)
  end

  def set_client
    @client = Client.find params[:id]
  end

end
