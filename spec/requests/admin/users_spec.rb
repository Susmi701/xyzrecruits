require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    before{get admin_users_path}

    it "returns a success response" do
      expect(response).to be_successful
    end
      it_behaves_like "a response with template", :index
  end

  describe 'GET #new' do
    before{get new_admin_user_path}
    it 'assigns @user as a new User' do
      expect(assigns(:user)).to be_a_new(User)
    end
    it_behaves_like "a response with template", :new
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post admin_users_path, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'sends reset password instructions' do
        expect_any_instance_of(User).to receive(:send_reset_password_instructions)
        post admin_users_path, params: { user: attributes_for(:user) }
      end

      it 'redirects to the index page with a success notice' do
        post admin_users_path, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(admin_users_path)
        expect(flash[:notice]).to eq('User was successfully created. An email has been sent to set up their password.')
      end
    end

    context 'with invalid attributes' do
      before{post admin_users_path, params: { user: attributes_for(:user, email: nil) }}
      it 'does not save the new user' do
        expect { subject }.not_to change(User, :count)
      end

      it_behaves_like "a response with template", :new
      it_behaves_like "an unprocessable_entity"
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      user
      expect {
        delete admin_user_path(user)
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the index page with a success notice' do
      delete admin_user_path(user)
      expect(response).to redirect_to(admin_users_path)
      expect(flash[:notice]).to eq('User was successfully deleted.')
    end
  end

  describe 'authorization' do
    context 'when the user is not an admin' do
      before do
        sign_out admin_user
        sign_in user
        get admin_users_path
      end

       it_behaves_like "admin access required"
    end
  end
end
