module Translators
  class Client
    def self.translate(client)
      {
        cnpj: only_number(client[:cnpj]),
        company_name: client[:company_name],
        officials_total: client[:officials_total]
      }
    end

    def self.only_number(cpf)
      cpf.gsub(/\D/, '')
    end
  end
end
