module Mutations
  class DeleteDiscussion < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false

    def resolve(id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user
      raise GraphQL::ExecutionError, "Admin access required" unless user.admin?

      discussion = Discussion.find(id)
      discussion.soft_delete
      { success: true }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Discussion not found")
    end
  end
end
