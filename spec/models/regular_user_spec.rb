require 'spec_helper'

describe RegularUser do
  it { should have_secure_password }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it "generates a random token when the user is created" do
    bob = Fabricate(:regular_user)
    expect(bob.token).to be_present
  end
end