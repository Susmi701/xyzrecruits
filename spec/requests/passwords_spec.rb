require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe 'PUT #update' do
  let(:user) { create(:user, status: false) }

  before do
    token = user.send_reset_password_instructions
    put user_password_path, params: {
      user: {
        reset_password_token: token,
        password: 'newpassword',
        password_confirmation: 'newpassword'
      }
    }
  end

  it 'updates the user password' do
    expect(user.reload.valid_password?('newpassword')).to be true
  end

  it 'sets the user status to true' do
    expect(user.reload.status).to be true
  end

  it 'redirects to the root path' do
    expect(response).to redirect_to(root_path)
  end
end
end
