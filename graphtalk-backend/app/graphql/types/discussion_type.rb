module Types
    class DiscussionType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :content, String, null: true
      field :community, Types::CommunityType, null: false
      field :comments, [Types::CommentType], null: true
    end
  end
  