class RemoveCnpjToClients < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :cnpj, :string
  end
end
