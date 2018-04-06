class RemoveProcessesQuantityFromCompany < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :processes_quantity, :integer
  end
end
