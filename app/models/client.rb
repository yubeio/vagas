class Client < ApplicationRecord
  validates :cnpj, :razao_social, :n_funcionarios, presence: true
 
  enum status: [ :active, :archived]

  has_many :proccess
end
