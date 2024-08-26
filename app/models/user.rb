class User < ApplicationRecord
  enum role: { user: 0, admin: 1 } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        validates :name, presence: true, length: { maximum: 50 }
        validates :email,length: {maximum: 105},uniqueness: { case_sensitive: false },format: {with: VALID_EMAIL_REGEX } 
end
