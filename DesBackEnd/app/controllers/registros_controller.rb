class RegistrosController < ApplicationController

  def index
    @clientes = Cliente.all
    @processos = Processo.all
  end

end
