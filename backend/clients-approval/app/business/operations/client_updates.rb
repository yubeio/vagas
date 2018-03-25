module Operations
  class ClientUpdates

    def initialize(total, client_id)
      @total = total
      @client_id = client_id
    end

    def add_process_total
      client = Client.find(@client_id)
      client.update!(process_total: new_sum_value(client.process_total))
    end

    def sub_process_total
      client = Client.find(@client_id)
      client.update!(process_total: new_sub_value(client.process_total))
    end

    private

    def new_sum_value(process_total)
      process_total + @total
    end

    def new_sub_value(process_total)
      process_total - 1
    end
  end
end
