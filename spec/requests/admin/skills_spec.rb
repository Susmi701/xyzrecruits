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
      expect(flash[:alert]).to eq('Skill was successfully destroyed.')
    end
  end

  describe 'GET #edit' do
    before {get edit_admin_skill_path(skill)}
    it 'assigns @skills and renders the index template' do
      expect(assigns(:skills)).to be_present
    end
    it_behaves_like "a response with template", :index
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:valid_attributes) { { name: 'Updated Name' } }
      before {put admin_skill_path(skill), params: { skill: { name: 'Updated Name' } } }
      it 'updates the skill and redirects to the index' do
        skill.reload
        expect(skill.name).to eq('Updated Name')
      end
      it "redirects to the categories list" do
        expect(response).to redirect_to(admin_skills_path)
      end
    end

    context 'with invalid attributes' do
      before{put admin_skill_path(skill), params: { skill: attributes_for(:skill, name: nil) }}
      it 'does not update the skill and renders the index template with unprocessable_entity status' do
        skill.reload
        expect(skill.name).not_to eq('')
        expect(response.status).to eq(422)
      end
      it_behaves_like "a response with template", :index
        it_behaves_like "an unprocessable_entity"
    end
  end
end
