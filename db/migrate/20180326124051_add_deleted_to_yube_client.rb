class AddDeletedToYubeClient < ActiveRecord::Migration[5.1]
  def change
    add_column :yube_clients, :deleted, :boolean, null: false, default: false
  end
end
