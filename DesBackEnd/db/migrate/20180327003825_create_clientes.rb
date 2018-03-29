class CreateClientes < ActiveRecord::Migration[5.1]
  def change
    create_table :clientes do |t|
      t.string :cnpj
      t.string :razao_social
      t.integer :num_funcionarios
      t.references :processo, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
