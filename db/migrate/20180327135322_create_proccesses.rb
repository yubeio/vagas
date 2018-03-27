class CreateProccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :proccesses do |t|
      t.string :name
      t.text :description
      t.integer :status, default: 1
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
