require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:email) }
    
    it { should validate_length_of(:email).is_at_most(105) }
    it { should allow_value('example@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    
    it 'validates email format' do
      should allow_value('example@example.com').for(:email)
        .with_message('is invalid')
      should_not allow_value('invalid_email').for(:email)
        .with_message('is invalid')
    end
  end
end
