class AuthenticationController < ApplicationController
	skip_before_action :authenticate_request

	def authenticate
		client_auth_service =
		  ClientAuthenticationService.new(
			  params[:client][:username], params[:client][:password]
	    ).encode_jwt

	  if client_auth_service.present?
	  	render json: { auth_token: client_auth_service }, status: :ok
	  else
	  	render json: { error: 'Invalid credentials' }, status: :unauthorized
	  end
	end
end
