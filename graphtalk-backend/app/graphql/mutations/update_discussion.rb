module Mutations
  class UpdateDiscussion < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :content, String, required: false

    field :discussion, Types::DiscussionType, null: false

    def resolve(id:, title: nil, content: nil)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user

      discussion = Discussion.find(id)
      raise GraphQL::ExecutionError, "Permission denied" unless discussion.user_id == user.id || user.admin?

      discussion.update!(title: title, content: content)
      { discussion: discussion }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Discussion not found")
    end
  end
end
