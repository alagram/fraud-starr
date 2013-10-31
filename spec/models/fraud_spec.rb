require 'spec_helper'

describe Fraud do
  it { should belong_to(:fraud_type) }
  it { should have_many(:images) }
  it { should accept_nested_attributes_for(:images) }
end