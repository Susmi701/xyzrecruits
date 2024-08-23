require 'rails_helper'

RSpec.describe "Admin::Skills", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:skill) { create(:skill) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
  before{get admin_skills_path}
    it 'assigns @skills and @skill' do
      expect(assigns(:skill)).to be_a_new(Skill)
    end
    it_behaves_like "a response with template", :index
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new skill' do
        expect {
          post admin_skills_path, params: { skill: attributes_for(:skill) }
        }.to change(Skill, :count).by(1)
      end

      it 'redirects to the index page with a success notice' do
        post admin_skills_path, params: { skill: attributes_for(:skill) }
        expect(response).to redirect_to(admin_skills_path)
        expect(flash[:notice]).to eq('Skill was successfully created.')
      end
    end

    context 'with invalid attributes' do
      before{post admin_skills_path, params: { skill: attributes_for(:skill, name: nil) }}
      it 'does not save the new skill' do
        expect { subject }.not_to change(Skill, :count)
      end

      it_behaves_like "a response with template", :index
      it_behaves_like "an unprocessable_entity"
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the skill' do
      skill
      expect {
        delete admin_skill_path(skill)
      }.to change(Skill, :count).by(-1)
    end

    it 'redirects to the index page with a success notice' do
      delete admin_skill_path(skill)
      expect(response).to redirect_to(admin_skills_path)
      expect(flash[:notice]).to eq('Skill was successfully destroyed.')
    end
  end
end
