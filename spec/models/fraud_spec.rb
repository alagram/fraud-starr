require 'spec_helper'

describe Fraud do
  it { should belong_to(:fraud_type) }
  it { should have_many(:images) }
  it { should accept_nested_attributes_for(:images) }

  describe "search" do
    it "returns an empty array if there is no match" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" }, fraud_search: "@kofi")
      f2 = Fabricate(:fraud, properties: { "Facebook Address"=>"https://facebook.com/johnny" }, fraud_search: "https://facebook.com/johnny")
      expect(Fraud.search("@test")).to eq([])
    end
    it "returns an array of one fradulent activity for an exact match" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" }, fraud_search: "@kofi")
      f2 = Fabricate(:fraud, properties: { "Facebook Address"=>"https://facebook.com/johnny" }, fraud_search: "https://facebook.com/johnny")
      expect(Fraud.search("@kofi")).to eq([f1])
    end
    it "returns an array of all matches ordered by created at" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" }, fraud_search: "@kofi", created_at: 1.day.ago)
      f2 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" }, fraud_search: "@kofi")
      expect(Fraud.search("@kofi")).to eq([f2, f1])
    end
    it "returns an empty array for a search with an empty string" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" }, fraud_search: "@kofi")
      f2 = Fabricate(:fraud, properties: { "Facebook Address"=>"https://facebook.com/johnny" }, fraud_search: "https://facebook.com/johnny")
      expect(Fraud.search("")).to eq([])
    end
  end
end