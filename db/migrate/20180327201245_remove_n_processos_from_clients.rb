class RemoveNProcessosFromClients < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :n_processos, :string
  end
end
