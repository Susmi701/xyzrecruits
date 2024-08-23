require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:website) }
    
    it { should validate_length_of(:email).is_at_most(105) }
    it { should allow_value('example@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    
    it { should validate_length_of(:address).is_at_most(255) }
    it { should validate_length_of(:phone).is_at_most(13) }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_length_of(:website).is_at_most(255) }
    
    it do
      should allow_value('http://example.com', 'https://example.com').for(:website)
        .with_message('must be a valid URL')
    end
    it do
      should_not allow_value('invalid_url').for(:website)
        .with_message('must be a valid URL')
    end
  end
end
