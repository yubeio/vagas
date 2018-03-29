class CreateClientProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :client_processes do |t|
      t.string :name
      t.text :description
      t.integer :process_status
      t.references :client

      t.timestamps
    end
  end
end
