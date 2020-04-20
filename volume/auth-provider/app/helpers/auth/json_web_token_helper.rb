module Auth
  module JsonWebTokenHelper
    SECRET_KEY = Rails.application.credentials.jwt[:secret_key].to_s

    def encode_user(user, exp = 24.hours.from_now)
      payload = {}
      payload[:exp] = exp.to_i
      payload[:user_id] = user.id
      JWT.encode(payload, SECRET_KEY)
    end

    def decode_token(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    rescue JWT::DecodeError => e
      Rails.logger.info e
      nil
    end

    def user_by_token(token)
      decoded = decode_token(token)

      User.find(decoded[:user_id]) if decoded
    end
  end
end
