require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:jobs) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }

    it 'validates uniqueness of name (case insensitive)' do
      should validate_uniqueness_of(:name).case_insensitive
    end
  end
end
