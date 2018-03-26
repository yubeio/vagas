class Client < ApplicationRecord
  validates :cnpj, :razao_social, :n_funcionarios, :n_processos, presence: true
end
