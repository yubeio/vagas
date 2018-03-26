class ApplicationController < ActionController::API
	before_action :authenticate_request

  attr_reader :current_client

	private

	def authenticate_request
		@current_client =
		  RequestAuthorizationService.new(request.headers).authorize

    if @current_client.blank?
		  render json: { error: 'Client not authorized - invalid token' }, status: :unauthorized
		end
	end
end
