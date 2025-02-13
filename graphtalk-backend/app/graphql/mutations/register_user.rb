module Mutations
  class RegisterUser < BaseMutation
    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :role, String, required: false, default_value: "user"

    field :user, Types::UserType, null: false
    field :token, String, null: false

    def resolve(username:, email:, password:, role:)
      user = User.create!(
        username: username,
        email: email,
        password: password,
        role: role
      )
      token = JsonWebToken.encode(user_id: user.id, role: user.role)
      { user: user, token: token }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
