module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false
    field :token, String, null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user && user.authenticate(password)
        token = JsonWebToken.encode(user_id: user.id, role: user.role)
        { user: user, token: token }
      else
        GraphQL::ExecutionError.new("Invalid email or password")
      end
    end
  end
end
