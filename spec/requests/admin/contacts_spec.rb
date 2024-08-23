require 'rails_helper'

RSpec.describe "Admin::Contacts", type: :request do
  let(:admin) { create(:user, role: 1) }
  let(:non_admin) { create(:user, role: 0) }
  let(:contact) { create(:contact) }

  before do
    allow(Contact).to receive(:first).and_return(contact)
  end

  describe 'GET #edit' do
    context 'when user is admin' do
      before do
        sign_in admin
        get edit_admin_contacts_path
      end

      it 'assigns the first contact as @contact' do
        expect(assigns(:contact)).to eq(contact)
      end

       it_behaves_like "a response with template",:edit
    end

    context 'when user is not admin' do
      before do
        sign_in non_admin
        get edit_admin_contacts_path
      end

       it_behaves_like "admin access required"

    end
  end

  describe 'PATCH #update' do
    let(:valid_attributes) { attributes_for(:contact) }
    let(:invalid_attributes) { { email: 'invalid-email' } }

    context 'when user is admin' do
      before { sign_in admin }

      context 'with valid params' do
        before { patch admin_contacts_path, params: { contact: valid_attributes } }

        it 'updates the contact' do
          contact.reload
          expect(contact.address).to eq('address')
          expect(contact.phone).to eq('123456789')
          expect(contact.email).to eq('user@gmail.com')
          expect(contact.website).to eq('http://example.com')
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to(edit_admin_contacts_path(contact))
        end

        it 'sets a flash notice message' do
          expect(flash[:notice]).to eq('Contact was successfully updated.')
        end
      end

      context 'with invalid params' do
        before { patch admin_contacts_path, params: { contact: invalid_attributes } }

        it 'does not update the contact' do
          expect(contact.reload.email).not_to eq('invalid-email')
        end

        it_behaves_like "a response with template",:edit

        it_behaves_like "an unprocessable_entity"
      end
    end

    context 'when user is not admin' do
      before do
        sign_in non_admin
        patch admin_contacts_path, params: { contact: valid_attributes }
      end

      it_behaves_like "admin access required"
    end
  end
end
