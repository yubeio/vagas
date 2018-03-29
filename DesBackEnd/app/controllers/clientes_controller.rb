class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[show edit update destroy]

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show; end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
    options_for_select
  end

  # GET /clientes/1/edit
  def edit
    options_for_select
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Cliente foi Criado com Sucesso.' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to @cliente, notice: 'Cliente foi Atualizado com Sucesso.' }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    destroyReg
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: 'Cliente foi apagado do sistema' }
      format.json { head :no_content }
    end
  end

  private

  def options_for_select
    @processo_options_for_select = Processo.where(status: 1)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cliente_params
    params.require(:cliente).permit(:cnpj, :razao_social, :num_funcionarios, :processo_id, :status)
  end

  def destroyReg
    conn = ActiveRecord::Base.connection
    if conn.execute("UPDATE Clientes SET status = 0 WHERE ID = #{@cliente.id}")
      puts"Apagado"
    else
      puts"Não Apagou"
    end
  end
end
