class CreateProcedure < ActiveRecord::Migration[5.1]
  def change
    create_table :procedures do |t|
      t.string :name
      t.text :description
      t.string :status, default: 'Pending'
      t.boolean :deleted, default: false
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
