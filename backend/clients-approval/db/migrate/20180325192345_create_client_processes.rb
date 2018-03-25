class CreateClientProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :client_processes do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.references :client, foreign_key: true
      t.integer :active, default: 1

      t.timestamps
    end
  end
end
