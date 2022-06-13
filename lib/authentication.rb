# frozen_string_literal: true

module Authentication
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  JWT_EXP_SECS = 1.hour.to_i

  class << self
    def credentials(user)
      { user: user }.merge(encode(user))
    end

    def from_jwt(token)
      payload, = decode token
      user = User.find(payload['id'])

      { user: user, token: token }
    end

    def encode(user)
      exp = Time.now.to_i + JWT_EXP_SECS
      { token: JWT.encode({ id: user.id, exp: exp }, SECRET_KEY), exp: exp }
    end

    def decode(token)
      JWT.decode(token, SECRET_KEY)
    end
  end
end
