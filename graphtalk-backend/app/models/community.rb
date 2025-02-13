class Community < ApplicationRecord
    has_many :discussions, dependent: :destroy
end
