require 'spec_helper'

describe User do
  it { should have_many(:accounts).dependent(:destroy) }
  it { should have_many(:frauds) }
end