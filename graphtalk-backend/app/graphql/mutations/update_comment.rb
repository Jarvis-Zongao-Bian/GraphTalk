module Mutations
  class UpdateComment < BaseMutation
    argument :id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: false

    def resolve(id:, content:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user

      comment = Comment.find(id)
      raise GraphQL::ExecutionError, "Permission denied" unless comment.user_id == user.id || user.admin?

      comment.update!(content: content)
      { comment: comment }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Comment not found")
    end
  end
end
