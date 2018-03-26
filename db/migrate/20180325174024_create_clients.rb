class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.integer :cnpj
      t.string :razao_social
      t.integer :n_funcionarios
      t.integer :n_processos

      t.timestamps
    end
  end
end
