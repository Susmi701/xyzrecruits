require 'rails_helper'

RSpec.describe JobSkill, type: :model do
  describe 'associations' do
    it { should belong_to(:job) }
    it { should belong_to(:skill) }
  end
end
