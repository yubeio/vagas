class Client < ApplicationRecord
  has_many :ClientProcess

  validates_presence_of :cnpj, :razao_social, :total_employee, :total_process
end
