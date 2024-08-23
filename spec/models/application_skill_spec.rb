require 'rails_helper'

RSpec.describe ApplicationSkill, type: :model do
  describe 'associations' do
    it { should belong_to(:application) }
    it { should belong_to(:skill) }
  end
end
