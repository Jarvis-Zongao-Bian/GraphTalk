# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login_user, mutation: Mutations::LoginUser
    field :register_user, mutation: Mutations::RegisterUser
    field :create_comment, mutation: Mutations::CreateComment
    field :create_discussion, mutation: Mutations::CreateDiscussion
    field :create_community, mutation: Mutations::CreateCommunity
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
