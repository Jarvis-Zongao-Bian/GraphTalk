class Discussion < ApplicationRecord
  belongs_to :community
  has_many :comments, dependent: :destroy
end
