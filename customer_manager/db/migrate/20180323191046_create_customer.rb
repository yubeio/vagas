class CreateCustomer < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :cnpj
      t.string :corporate_name
      t.integer :employees
      t.integer :procedures_count, default: 0
      t.boolean :deleted, default: false
      t.timestamps
    end
  end
end
