class RequestAuthorizationService
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def authorize
    decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    @client =
      decoded_auth_token ? Client.find(decoded_auth_token[:client_id]) : nil

    @client || nil
  end

  private

  def http_auth_header
    if @headers['Authorization'].present?
      @headers['Authorization'].split(' ').last
    else
      errors.add(:toke, 'Missing token')
    end
  end
end
