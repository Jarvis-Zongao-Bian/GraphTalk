module Mutations
  class CreateComment < BaseMutation
    argument :content, String, required: true
    argument :discussion_id, ID, required: true

    field :comment, Types::CommentType, null: false

    def resolve(content:, discussion_id:)
      discussion = Discussion.find(discussion_id)
      comment = discussion.comments.create!(content: content)
      { comment: comment }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Discussion not found")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
