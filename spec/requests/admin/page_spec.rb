require 'rails_helper'

RSpec.describe "Admin::Pages", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:non_admin_user) { create(:user) }
  let!(:page_content) { create(:page_content) }

  describe "GET #edit" do
    context "when the user is an admin" do
      before do
         sign_in admin_user
         get edit_admin_page_contents_path 
      end

      it "assigns the requested page_content to @page_content" do
        expect(assigns(:page_content)).to eq(page_content)
      end

      it_behaves_like "a response with template", :edit
    end

    context "when the user is not an admin" do
      before do
         sign_in non_admin_user 
         get edit_admin_page_contents_path
      end

      it_behaves_like "admin access required"
    end
  end

  describe "PATCH #update" do
    context "when the user is an admin" do
      before { sign_in admin_user }

      context "with valid attributes" do
        it "purges the home_img if a new one is provided" do
          patch admin_page_contents_path, params: { page_content: { home_img: fixture_file_upload('spec/fixtures/files/new_sample_image.png') } }
          expect(page_content.reload.home_img.attached?).to be true
        end

        it "purges the ceo_img if a new one is provided" do
          patch admin_page_contents_path, params: { page_content: { ceo_img: fixture_file_upload('spec/fixtures/files/new_sample_image.png') } }
          expect(page_content.reload.ceo_img.attached?).to be true
        end

        it "updates the page content" do
          patch admin_page_contents_path, params: { page_content: { mission: "m" * 256 } }
          expect(page_content.reload.mission).to eq("m"*256)
        end

        it "redirects to the edit page with a success notice" do
          patch admin_page_contents_path, params: { page_content: { mission: "m" * 256 } }
          expect(response).to redirect_to(edit_admin_page_contents_path(page_content))
          expect(flash[:notice]).to eq('Page content was successfully updated.')
        end
      end

      context "with invalid attributes" do
        before{patch admin_page_contents_path, params: { page_content: { mission: "" } }}
        it "does not update the page content" do
          expect(page_content.reload.mission).not_to eq("")
        end

        it_behaves_like "a response with template", :edit
        it_behaves_like "an unprocessable_entity"
      end
    end

    context "when the user is not an admin" do
      before do
         sign_in non_admin_user 
         patch admin_page_contents_path, params: { page_content: { mission: "New Mission" } }
      end

      it_behaves_like "admin access required"
    end
  end
end
