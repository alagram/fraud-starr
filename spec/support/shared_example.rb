shared_examples "requires sign in" do
  it "redirects to the sign in path" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "tokenable" do
  it "generates a random token when the object is created" do
    expect(object.token).to be_present
  end
end