require 'spec_helper'

describe RegularUser do
  it { should have_secure_password }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should have_many(:frauds) }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:regular_user) }
  end
end