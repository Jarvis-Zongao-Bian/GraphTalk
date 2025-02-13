module Types
    class CommunityType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :discussions, [Types::DiscussionType], null: true
    end
  end
  