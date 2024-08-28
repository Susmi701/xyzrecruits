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

  describe 'image validation' do
    let(:page_content) { build(:page_content) }

    context 'when attaching valid images' do
      it 'should allow attaching a home_img' do
        page_content.home_img.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_image.png')), filename: 'sample_image.png', content_type: 'image/png')
        expect(page_content.home_img).to be_attached
      end

      it 'should allow attaching a ceo_img' do
        page_content.ceo_img.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_image.png')), filename: 'sample_image.png', content_type: 'image/png')
        expect(page_content.ceo_img).to be_attached
      end
    end

    context 'when attaching invalid images' do
      it 'rejects non-image files for home_img' do
        page_content.home_img.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample.pdf')), filename: 'sample.pdf', content_type: 'application/pdf')
        expect(page_content).not_to be_valid
        expect(page_content.errors[:home_img]).to include('must be a PNG, JPG, or JPEG image')
      end

      it 'rejects non-image files for ceo_img' do
        page_content.ceo_img.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample.pdf')), filename: 'sample.pdf', content_type: 'application/pdf')
        expect(page_content).not_to be_valid
        expect(page_content.errors[:ceo_img]).to include('must be a PNG, JPG, or JPEG image')
      end

      it 'rejects images larger than 10MB for home_img' do
        large_image = Tempfile.new(['large', '.jpg'])
        large_image.write("0" * 11.megabytes)
        large_image.rewind
        page_content.home_img.attach(io: large_image, filename: 'large.jpg', content_type: 'image/jpeg')
        expect(page_content).not_to be_valid
        expect(page_content.errors[:home_img]).to include('should be less than 10MB')
        large_image.close
        large_image.unlink
      end

      it 'rejects images larger than 10MB for ceo_img' do
        large_image = Tempfile.new(['large', '.jpg'])
        large_image.write("0" * 11.megabytes)
        large_image.rewind
        page_content.ceo_img.attach(io: large_image, filename: 'large.jpg', content_type: 'image/jpeg')
        expect(page_content).not_to be_valid
        expect(page_content.errors[:ceo_img]).to include('should be less than 10MB')
        large_image.close
        large_image.unlink
      end
    end
  end
  
end
