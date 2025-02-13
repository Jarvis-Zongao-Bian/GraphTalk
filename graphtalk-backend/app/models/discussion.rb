class Discussion < ApplicationRecord
  belongs_to :community
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
end
