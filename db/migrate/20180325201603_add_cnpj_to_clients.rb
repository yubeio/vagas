class AddCnpjToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :cnpj, :string
  end
end
