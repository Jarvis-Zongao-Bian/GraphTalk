module Types
    class CommunityInputType < Types::BaseInputObject
      description "Input fields for creating a community"
  
      argument :name, String, required: true
      argument :description, String, required: false
    end
  end
  