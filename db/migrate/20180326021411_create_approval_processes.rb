class CreateApprovalProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :approval_processes do |t|
      t.string :name
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
