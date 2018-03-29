class ClientProcess < ApplicationRecord
  belongs_to :client
  enum process_status: [:pendente, :aprovado, :rejeitado]

  validates_presence_of :name, :description, :process_status
end
