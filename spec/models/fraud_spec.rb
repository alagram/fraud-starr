require 'spec_helper'

describe Fraud do
  it { should belong_to(:fraud_type) }
end