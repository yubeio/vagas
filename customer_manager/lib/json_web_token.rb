class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    begin
      body =
        JWT.decode(
          token,
          Rails.application.secrets.secret_key_base
        )

      HashWithIndifferentAccess.new(body.first)
    rescue StandardError => error
      nil
    end
  end
end
