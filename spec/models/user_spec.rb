require 'spec_helper'

describe User do
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it do
    Fabricate(:user, email: "alice@example.com")
    should validate_uniqueness_of(:email)
  end
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should have_secure_password }
end