class User < ApplicationRecord
    has_secure_password # Enables bcrypt password hashing
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :role, inclusion: { in: %w[admin moderator user] }
  
    has_many :communities, dependent: :destroy
    has_many :discussions, dependent: :destroy
    has_many :comments, dependent: :destroy

    # Role-based authorization helpers
    def admin?
        role == "admin"
    end

    def moderator?
        role == "moderator"
    end

    def user?
        role == "user"
    end
  end
  