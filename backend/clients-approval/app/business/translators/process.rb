module Translators
  class Process

    def self.translate(process, client_id)
      {
        name: process[:name],
        description: process[:description],
        status: process[:status],
        client_id: client_id
      }
    end
  end
end
