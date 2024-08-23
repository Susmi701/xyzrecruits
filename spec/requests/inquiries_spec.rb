require 'rails_helper'

RSpec.describe "Inquiries", type: :request do
  before do
    create(:contact)
    create(:page_content)
  end
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { inquiry: attributes_for(:inquiry) } }

      it 'creates a new Inquiry' do
        expect {
          post inquiries_path, params: valid_params
        }.to change(Inquiry, :count).by(1)
      end

      it 'redirects to the contact path with a success notice' do
        post inquiries_path, params: valid_params
        expect(response).to redirect_to(contact_path)
        expect(flash[:notice]).to eq('Your inquiry has been submitted successfully.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { inquiry: attributes_for(:inquiry, email: nil) } }
      before{post inquiries_path, params: invalid_params}

      it 'does not create a new Inquiry' do
        expect { subject }.not_to change(Inquiry, :count)
      end

      it_behaves_like 'a response with template','home/contact'
      it_behaves_like 'an unprocessable_entity'
    end
  end
end
