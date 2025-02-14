module Mutations
  class CreateComment < BaseMutation
    argument :content, String, required: true
    argument :discussion_id, ID, required: true

    field :comment, Types::CommentType, null: false

    def resolve(content:, discussion_id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user

      discussion = Discussion.find(discussion_id)
      comment = discussion.comments.create!(content: content)

      # Publish notification to RabbitMQ
      RabbitMQClient.publish({
                               event: "new_comment",
                               discussion_id: discussion.id,
                               user: user.username,
                               message: content
                             })

      { comment: comment }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Discussion not found")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
