module Api
  module V1
    class ClientController < ApplicationController
      before_action :client_create_params, only:[:create]
      before_action :set_client, only:[:update, :destroy, :show]
      before_action :set_transaction, only:[:destroy]

      def index
        @clients = Client.all
        render json: { clients: @clients }
      rescue StandardError => e
        render json: { error: "Error while trying to list Clients => #{e}" }, status: :unprocessable_entity
      end

      def show
        render json: {client: @client}
      rescue StandardError => e
        render json: { error: "Error while trying to show Client => #{e}" }, status: :unprocessable_entity
      end

      def clients_with_deleted
        @clients = Client.with_deleted
        render json: { clients: @clients }
      rescue StandardError => e
        render json: { error: "Error while trying to show Deleted Clients => #{e}" }, status: :unprocessable_entity
      end

      def create
        @client_params.each { |param| Client.create(param) }
        render json: { message: 'Client(s) saved' }, status: 200
      rescue StandardError => e
        render json: { error: "Error while trying to crete new Client => #{e}" }, status: :unprocessable_entity
      end

      def update
        @client.update!(client_params)
        render json: { message: 'Client updated' }, status: 200
      rescue StandardError => e
        render json: { error: "Error while trying to update Client => #{e}" }, status: :unprocessable_entity
      end

      def destroy
        @record.transaction do
          ::Operations::ClientProcessUpdates.new(@client.id).update_active_status
          @client.destroy
          render json: { message: 'Client destroyed, but you can still check it information' }, status: 200
        end
      rescue StandardError => e
        render json: { error: "Error while trying to delete Client => #{e}" }, status: :unprocessable_entity
      end

      private

      def client_create_params
        @client_params = params[:clients].map { |param| ::Translators::Client.translate(param[:client]) }
      end

      def set_client
        @client = Client.find(params[:id])
      end

      def client_params
        params.require(:client).permit(:cnpj, :company_name, :officials_total)
      end
    end
  end
end
