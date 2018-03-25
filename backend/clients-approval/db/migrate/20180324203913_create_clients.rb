class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :cnpj
      t.string :company_name
      t.integer :officials_total
      t.integer :process_total, default: 0

      t.timestamps
    end
  end
end
