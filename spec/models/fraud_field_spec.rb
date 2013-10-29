require 'spec_helper'

describe FraudField do
  it { should belong_to(:fraud_type) }
end