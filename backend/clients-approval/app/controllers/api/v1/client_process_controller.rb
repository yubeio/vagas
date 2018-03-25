module Api
  module V1
    class ClientProcessController < ApplicationController
      before_action :process_create_params, only:[:create]
      before_action :set_process, only:[:update, :destroy]
      before_action :set_transaction, only:[:create, :destroy]

      def index
        @processes = ClientProcess.all
        render json: { procesess: @processes }
      end

      def create
        @record.transaction do
          @process_params.each { |param| ClientProcess.create(param) }
          ::Operations::ClientUpdates.new(@process_params.size, @client.id).add_process_total
          render json: { message: 'Process(es) saved' }, status: 200
        end
      rescue StandardError => e
        render json: { error: "Error while trying to crete new Process => #{e}" }, status: :unprocessable_entity
      end

      def update
        @process.update!(process_params)
        render json: { message: 'Process updated' }, status: 200
      rescue StandardError => e
        render json: { error: "Error while trying to update Process => #{e}" }, status: :unprocessable_entity
      end

      def destroy
        @record.transaction do
          @process.destroy
          ::Operations::Client.new.(@process,@process.client_id).sub_process_total
          render json: { message: 'Process was destroyed' }, status: 200
        end
      rescue StandardError => e
        render json: { error: "Error while trying to delete Process => #{e}" }, status: :unprocessable_entity
      end

      private

      def process_create_params
        @client = Client.where(cnpj: params[:client_cnpj]).first
        validate_client
        @process_params = params[:processes].map { |param| Translators::Process.translate(param[:process], @client.id) }
      end

      def validate_client
        render json: { error: "You can't create a process for a deleted client" } unless @client.deleted_at.nil?
      end

      def set_process
        @process = ClientProcess.find(params[:id])
      end

      def process_params
        params.require(:client_process).permit(:name, :description, :status, :active)
      end
    end
  end
end
