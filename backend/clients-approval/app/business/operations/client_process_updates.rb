module Operations
  class ClientProcessUpdates

    def initialize(client_id)
      @client_id = client_id
    end

    def update_active_status
      @processes = ClientProcess.where(client_id: @client_id)
      @processes.each { |process| update_active(process)}
    end

    private

    def update_active(process)
      process.update!(active: 0)
    end
  end
end
