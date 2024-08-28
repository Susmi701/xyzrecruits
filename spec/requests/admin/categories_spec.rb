require 'rails_helper'

RSpec.describe "Admin::Categories", type: :request do
  let(:category) { create(:category) }
  let(:valid_attributes) { { name: "Valid Category Name" } }
  let(:invalid_attributes) { { name: '' } }
  let(:user) { create(:user) }

  context 'when user is not signed in' do
    it_behaves_like "redirects to sign-in" do
      before { get admin_categories_path }
    end
  
    it_behaves_like "redirects to sign-in" do
      before { post admin_categories_path, params: { category: valid_attributes }}
    end
  
    it_behaves_like "redirects to sign-in" do
      before { get edit_admin_category_path(category) }
    end
  
    it_behaves_like "redirects to sign-in" do
      before { patch admin_category_path(category), params: { category: { name: 'Updated' } }}
    end
  end

  context 'when user is signed in' do
    before do
      sign_in user
    end

    describe "GET #index" do
      let!(:categories) { create_list(:category, 3) }
      before{ get admin_categories_path}

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "assigns all categories as @categories" do
        expect(assigns(:categories)).to eq(categories)
      end

      it "assigns a new Category as @category" do
        expect(assigns(:category)).to be_a_new(Category)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Category" do
          expect {
            post admin_categories_path, params: { category: valid_attributes }
          }.to change(Category, :count).by(1)
        end

        it "redirects to the categories list" do
          post admin_categories_path, params: { category: valid_attributes }
          expect(response).to redirect_to(admin_categories_path)
        end
      end

     context "with invalid params" do
        before { post admin_categories_path, params: { category: invalid_attributes } }

        it "does not create a new Category" do
          expect { subject }.not_to change(Category, :count)
        end

        it_behaves_like "a response with template", :index
        it_behaves_like "an unprocessable_entity"
      end
    end

    describe "GET #edit" do
      before {get edit_admin_category_path(category)}

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "assigns the requested category as @category" do
        expect(assigns(:category)).to eq(category)
      end

      it_behaves_like "a response with template", :index
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { name: 'Updated Category' } }
        before {put admin_category_path(category), params: { category: { name: 'Updated Name' } } }

        it "updates the requested category" do
          category.reload
          expect(category.name).to eq('Updated Name')
        end

        it "redirects to the categories list" do
          expect(response).to redirect_to(admin_categories_path)
        end
      end

      context "with invalid params" do
        before{put admin_category_path(category), params: { category: invalid_attributes }}
        
        it_behaves_like "a response with template", :index
        it_behaves_like "an unprocessable_entity"
      end
    end

    describe 'DELETE #destroy' do
      let!(:category_with_jobs) { create(:category) }
      let!(:category_without_jobs) { create(:category) }
      context 'when the category has associated jobs' do
        before do
          create(:job, category: category_with_jobs)
        end

        it 'does not delete the category and redirects with an alert' do
          expect {
            delete admin_category_path(category_with_jobs)
          }.not_to change(Category, :count)

          expect(response).to redirect_to(admin_categories_path)
          expect(flash[:alert]).to eq('Cannot delete category because it has associated jobs.')
        end
      end

      context 'when the category does not have associated jobs' do
        it 'deletes the category and redirects with a notice' do
          expect {
            delete admin_category_path(category_without_jobs)
          }.to change(Category, :count).by(-1)

          expect(response).to redirect_to(admin_categories_path)
          expect(flash[:notice]).to eq('Category was successfully destroyed.')
        end
      end
    end

  end
end
