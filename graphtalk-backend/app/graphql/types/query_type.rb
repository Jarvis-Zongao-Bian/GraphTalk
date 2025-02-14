# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    # Fetch all communities
    field :communities, [Types::CommunityType], null: false

    # Fetch a single community by ID
    field :community, Types::CommunityType, null: false do
      argument :id, ID, required: true
    end

    # Fetch all discussions
    field :discussions, [Types::DiscussionType], null: false

    # Fetch a single discussion by ID
    field :discussion, Types::DiscussionType, null: false do
      argument :id, ID, required: true
      argument :limit, Integer, required: false, default_value: 10
      argument :offset, Integer, required: false, default_value: 0
    end

    # Fetch comments for a discussion
    field :comments, [Types::CommentType], null: false do
      argument :discussion_id, ID, required: true
      argument :limit, Integer, required: false, default_value: 10
      argument :offset, Integer, required: false, default_value: 0
    end

    def comments(discussion_id:)
      Discussion.find(discussion_id).comments
      Comment.where(discussion_id: discussion_id).order(created_at: :desc).limit(limit).offset(offset)
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new("Discussion not found")
    end

    def communities
      Rails.cache.fetch("all_communities", expires_in: 10.minutes) do
        Community.all
      end
    end

    def community(id:)
      Community.find(id)
    end

    def discussions
      Discussion.order(created_at: :desc).limit(limit).offset(offset)
    end

    def discussion(id:)
      Discussion.find(id)
    end

    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :filtered_discussions, [Types::DiscussionType], null: false do
      argument :community_id, ID, required: false
      argument :sort_by, String, required: false, default_value: "latest"
    end

    def filtered_discussions(community_id: nil, sort_by: "latest")
      query = community_id ? Discussion.where(community_id: community_id) : Discussion.all

      case sort_by
      when "latest"
        query.order(created_at: :desc)
      when "popular"
        query.left_joins(:comments).group(:id).order("COUNT(comments.id) DESC")
      else
        query
      end
    end
  end
end
