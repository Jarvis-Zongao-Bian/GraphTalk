class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = 15.minutes.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.refresh_token(user_id)
      JWT.encode({ user_id: user_id, refresh: true, exp: 7.days.from_now.to_i }, SECRET_KEY)
    end

    def self.decode(token)
      body = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
