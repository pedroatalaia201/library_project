require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  enum roles: { reader: 0, author: 1 }

  class << self
    def authenticate_user(user_params:, enc_password:)
      user = find_by(**user_params)

      return true if user.present? && user.authenticate(enc_password)

      false
    end
  end
end
