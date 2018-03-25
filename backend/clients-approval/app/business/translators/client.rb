module Translators
  class Client
    def self.translate(client)
      {
        cnpj: client[:cnpj],
        company_name: client[:company_name],
        officials_total: client[:officials_total]
      }
    end
  end
end
