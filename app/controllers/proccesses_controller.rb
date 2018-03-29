class ProccessesController < ApplicationController
  def new
    @proccess = Proccess.new
    @client = Client.find(params[:client_id])
  end

  def create 
    @client = Client.find(params[:client_id])
    @proccess = @client.proccess.new(proccess_params)
    if @proccess.save
      flash[:success] = "Processo cadastrado com sucesso"
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def edit
    @client = Client.find(params[:client_id])
    @proccess = Proccess.find(params[:id])
  end

  def update
    @client = Client.find(params[:client_id])
    if @proccess = @client.proccess.update(proccess_params) 
      flash[:success] = "Processo cadastrado com sucesso"
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def aproved
    proccess = Proccess.find(params[:proccess_id])
    if proccess.aproved!
      flash[:success] = 'Proposta aceita com sucesso'
      redirect_to client_path(proccess.client)
    end
  end

  def rejected
    proccess = Proccess.find(params[:proccess_id])
    if proccess.rejected!
      flash[:notice] = 'Proposta rejeitada com sucesso'
      redirect_to client_path(proccess.client)
    end
  end
  
  private
  def proccess_params
    params.require(:proccess).permit(:name, :description)
  end
end
