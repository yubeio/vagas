class AddStatusToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :status, :integer, default: 0
  end
end
