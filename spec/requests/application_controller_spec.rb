require 'rails_helper'
RSpec.describe 'ApplicationController', type: :request do
  describe 'before actions' do
    let(:contact) { create(:contact) }
    let(:page_content) { create(:page_content) }

    before do
      allow(Contact).to receive(:first).and_return(contact)
      allow(PageContent).to receive(:first).and_return(page_content)
    end

    it 'sets contact details' do
       get root_path
      expect(assigns(:contact)).to eq(contact)
    end

    it 'sets page details' do
       get root_path
      expect(assigns(:pagecontent)).to eq(page_content)
    end
  end
end