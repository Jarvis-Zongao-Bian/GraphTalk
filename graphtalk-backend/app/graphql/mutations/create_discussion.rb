# frozen_string_literal: true

module Mutations
  class CreateDiscussion < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: false
    argument :community_id, ID, required: true

    field :discussion, Types::DiscussionType, null: false

    def resolve(title:, content: nil, community_id:)
      community = Community.find(community_id)
      discussion = community.discussions.create!(title: title, content: content)
      { discussion: discussion }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Community not found")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
