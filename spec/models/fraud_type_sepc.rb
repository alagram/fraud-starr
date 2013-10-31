require 'spec_helper'

describe FraudType do
  it { should have_many(:fields) }
  it { should accept_nested_attributes_for(:fields) }
  it { should validate_presence_of(:name) }
end