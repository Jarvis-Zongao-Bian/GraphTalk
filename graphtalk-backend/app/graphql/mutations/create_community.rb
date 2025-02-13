# module Mutations
#   class CreateCommunity < BaseMutation
#     class CreateCommunityInput < Types::BaseInputObject
#       graphql_name "CreateCommunityInput"

#       argument :name, String, required: true
#       argument :description, String, required: false
#     end

#     argument :input, CreateCommunityInput, required: true

#     field :community, Types::CommunityType, null: false

#     def resolve(input:)
#       community = Community.create!(name: input[:name], description: input[:description])
#       { community: community }
#     rescue ActiveRecord::RecordInvalid => e
#       GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
#     end
#   end
# end
module Mutations
  class CreateCommunity < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: false

    field :community, Types::CommunityType, null: false

    def resolve(name:, description: nil)
      community = Community.create!(name: name, description: description)
      { community: community }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end