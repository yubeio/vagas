class ClientProcess < ApplicationRecord
  belongs_to :client

  enum status: { pendente: 1, aprovado: 2, rejeitado: 3 }
end
