require 'rails_helper'

RSpec.describe "Admin::Inquiries", type: :request do
  let(:user) { create(:user) }
  context 'when user is not signed in' do
      before{get admin_inquiries_path}
      it_behaves_like "redirects to sign-in"
  end

  describe 'GET #index' do
    context 'when user is logged in' do
      let!(:inquiries) {create_list(:inquiry, 15)}

      before do
        sign_in user
        get admin_inquiries_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'assigns @inquiries' do
        expect(assigns(:inquiries)).to eq(inquiries.first(10))
      end

      it 'paginates the inquiries' do
        get admin_inquiries_path, params: { page: 2 }
        expect(assigns(:inquiries).current_page).to eq(2)
      end

      it_behaves_like "a response with template", :index
    end
  end

end
