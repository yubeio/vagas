class AddDisabledToClientProcess < ActiveRecord::Migration[5.1]
  def change
    add_column :client_processes, :disabled, :boolean, :default => false
  end
end
