class AddUniqueIndexToClient < ActiveRecord::Migration[5.1]
  def change
    add_index :clients, :username, unique: true
  end
end
