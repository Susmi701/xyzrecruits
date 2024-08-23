shared_examples "a response with template" do |template|
  it "renders the #{template} view" do
    expect(response).to render_template(template)
  end
end
shared_examples "an unprocessable_entity" do
  it "returns unprocessable_entity status with invalid params" do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

shared_examples "redirects to sign-in" do
  it "redirects to the sign-in page" do
    expect(response).to redirect_to(new_user_session_path)
  end
end

shared_examples "admin access required" do
  it "redirects to root path" do
    expect(response).to redirect_to(root_path)
  end

  it "sets a flash alert message" do
    expect(flash[:alert]).to eq('Access denied.')
  end
end

