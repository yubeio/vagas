class CreateCompanyProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :company_processes do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
