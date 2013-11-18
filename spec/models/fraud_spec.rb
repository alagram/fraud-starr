require 'spec_helper'

describe Fraud do
  it { should belong_to(:fraud_type) }
  it { should have_many(:images) }
  it { should accept_nested_attributes_for(:images) }

  describe "search" do
    it "returns an empty array if there is no match" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@agram" })
      f2 = Fabricate(:fraud, properties: { "Facebook Address"=>"https://facebook.com/johnny" })
      expect(Fraud.search("@test")).to eq[]
    end
    it "returns an array of one one video for an exact match"
  end
end