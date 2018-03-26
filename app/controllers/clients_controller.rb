class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  def create
    @client = Client.create(client_params)
    if @client.save
      redirect_to @client
    else
      render 'new'
    end
  end

  def show
    id = params[:id]
    @client = Client.find(id)
  end

  private
  def client_params
    params.require(:client).permit(:cnpj, :razao_social, :n_funcionarios, :n_processos)
  end
end
