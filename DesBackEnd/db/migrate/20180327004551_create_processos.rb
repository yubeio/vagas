class CreateProcessos < ActiveRecord::Migration[5.1]
  def change
    create_table :processos do |t|
      t.string :nome
      t.text :descricao
      t.string :situacao
      t.integer :status

      t.timestamps
    end
  end
end
