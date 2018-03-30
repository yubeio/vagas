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
    @proccess = @client.proccess.where({status: [1, 2]})
  end

  def edit
    id = params[:id]
    @client = Client.find(id)
  end

  def update
    @client = Client.find(params[:id])
    if @client = @client.update(client_params)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def archived
    client = Client.find(params[:client_id])
    if client.archived!
      flash[:notice] = 'Cliente excluido'
      redirect_to root_path
    end
  end

  private
  def client_params
    params.require(:client).permit(:cnpj, :razao_social, :n_funcionarios)
  end
end
