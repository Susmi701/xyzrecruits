require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:email).is_at_most(105) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('user@example,com').for(:email) }
    it { should_not allow_value('userexample.com').for(:email) }
  end
  describe 'enums' do
    it { should define_enum_for(:role).with_values(user: 0, admin: 1) }
  end
end
