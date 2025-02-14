module Mutations
  class DeleteComment < BaseMutation
    argument :comment_id, ID, required: true

    field :success, Boolean, null: false

    def resolve(comment_id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user
      raise GraphQL::ExecutionError, "Moderator access required" unless user.moderator? || user.admin?

      comment = Comment.find(comment_id)
      comment.destroy
      { success: true }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Comment not found")
    end
  end
end
