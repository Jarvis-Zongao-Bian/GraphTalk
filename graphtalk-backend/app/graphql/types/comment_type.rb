module Types
    class CommentType < Types::BaseObject
      field :id, ID, null: false
      field :content, String, null: false
      field :discussion, Types::DiscussionType, null: false
    end
  end
  