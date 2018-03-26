class YubeClientsController < ApplicationController
  before_action :set_yube_client, only: [:show, :update, :destroy]

  def index
    @yube_clients = YubeClient.all

    render json: @yube_clients
  end

  def show
    render json: @yube_client
  end

  def create
    @yube_client = YubeClient.new(yube_client_params)

    if @yube_client.save
      render json: @yube_client, status: :created, location: @yube_client
    else
      render json: @yube_client.errors, status: :unprocessable_entity
    end
  end

  def update
    if @yube_client.update(yube_client_params)
      render json: @yube_client
    else
      render json: @yube_client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @yube_client.destroy
  end

  private

  def set_yube_client
    @yube_client = YubeClient.find(params[:id])
  end

  def yube_client_params
    params.require(:yube_client).permit(:document_cnpj, :social_name, :employees_quantity)
  end
end
