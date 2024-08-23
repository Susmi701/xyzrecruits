require 'rails_helper'

RSpec.describe PageContent, type: :model do
  describe 'associations' do
    it { should have_one_attached(:home_img) }
    it { should have_one_attached(:ceo_img) }
  end

  describe 'validations' do
    it { should validate_presence_of(:home_header) }
    it { should validate_presence_of(:mission) }
    it { should validate_presence_of(:vision) }
    it { should validate_presence_of(:about_header) }
    it { should validate_presence_of(:about_us) }
    it { should validate_presence_of(:history) }
    it { should validate_presence_of(:ceo) }
    it { should validate_presence_of(:contact_header) }

    it { should validate_length_of(:mission).is_at_least(255) }
    it { should validate_length_of(:vision).is_at_least(255) }
    it { should validate_length_of(:history).is_at_least(255) }
    it { should validate_length_of(:about_us).is_at_least(255) }
  end

  describe 'attachments' do
    let(:page_content) { build(:page_content) }

    it 'should allow attaching a home_img' do
      page_content.home_img.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_image.png')), filename: 'sample_image.png', content_type: 'image/png')
      expect(page_content.home_img).to be_attached
    end

    it 'should allow attaching a ceo_img' do
      page_content.ceo_img.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_image.png')), filename: 'sample_image.png', content_type: 'image/png')
      expect(page_content.ceo_img).to be_attached
    end
  end
end
