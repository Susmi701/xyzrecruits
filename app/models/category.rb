class Category < ApplicationRecord
  has_many :jobs, dependent: :nullify
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
end
