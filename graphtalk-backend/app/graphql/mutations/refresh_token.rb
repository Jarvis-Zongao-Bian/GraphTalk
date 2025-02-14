module Mutations
  class RefreshToken < BaseMutation
    argument :refresh_token, String, required: true

    field :token, String, null: false

    def resolve(refresh_token:)
      decoded = JsonWebToken.decode(refresh_token)
      raise GraphQL::ExecutionError, "Invalid or expired refresh token" unless decoded && decoded[:refresh]

      user = User.find_by(id: decoded[:user_id])
      raise GraphQL::ExecutionError, "User not found" unless user

      new_token = JsonWebToken.encode(user_id: user.id, role: user.role)
      { token: new_token }
    end
  end
end
