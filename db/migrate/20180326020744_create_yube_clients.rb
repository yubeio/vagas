class CreateYubeClients < ActiveRecord::Migration[5.1]
  def change
    create_table :yube_clients do |t|
      t.string :document_cnpj
      t.string :social_name
      t.integer :employees_quantity

      t.timestamps
    end
  end
end
