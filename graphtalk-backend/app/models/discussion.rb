class Discussion < ApplicationRecord
  belongs_to :community
  has_many :comments, dependent: :destroy

  scope :active, -> { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end
end
