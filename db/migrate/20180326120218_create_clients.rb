class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :cnpj
      t.string :razao_social
      t.integer :total_employee
      t.integer :total_process

      t.timestamps
    end
  end
end
