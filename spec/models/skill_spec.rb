require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'associations' do
    it { should have_many(:application_skills).dependent(:destroy) }
    it { should have_many(:applications).through(:application_skills) }
    it { should have_many(:job_skills).dependent(:destroy) }
    it { should have_many(:jobs).through(:job_skills) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
