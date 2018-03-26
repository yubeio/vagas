class ClientAuthenticationService
  prepend SimpleCommand

  def initialize(username, password)
  	@username = username
  	@password = password
  end

  def encode_jwt
  	JsonWebToken.encode(client_id: @client.id) if client_authenticated?
  end

  private

  def client_authenticated?
  	@client = Client.where(username: @username).first

    if @client.present? && @client.authenticate(@password)
    	true
    else
    	false
    end
  end
end
