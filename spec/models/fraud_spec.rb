require 'spec_helper'

describe Fraud do
  it { should belong_to(:fraud_type) }
  it { should have_many(:images) }
  it { should accept_nested_attributes_for(:images) }
  it { should belong_to(:user) }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:fraud) }
  end

  describe "search" do
    it "returns an empty array if there is no match" do
      f1 = Fabricate(:fraud)
      expect(Fraud.search("@test")).to eq([])
    end
    it "returns an array of one fradulent activity for an exact match" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" })
      f2 = Fabricate(:fraud)
      expect(Fraud.search("@kofi")).to eq([f1])
    end
    it "returns an array of all matches ordered by created at" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" }, created_at: 1.day.ago)
      f2 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" })
      expect(Fraud.search("@kofi")).to eq([f2, f1])
    end
    it "returns an empty array for a search with an empty string" do
      f1 = Fabricate(:fraud, properties: { "Twitter Handle"=>"@kofi" })
      expect(Fraud.search("")).to eq([])
    end
  end

  describe "#display_text" do
    it "displays text when there is one word" do
      fraud = Fabricate(:fraud, description: "Enjoy!")
      expect(fraud.display_text).to eq("Enjoy!")
    end

    it "displays text when there is more than one word" do
      fraud = Fabricate(:fraud, description: "This will pass")
      expect(fraud.display_text).to eq("This will pass")
    end

    it "displays up to four words" do
      fraud = Fabricate(:fraud, description: "Ruby on Rails really rocks!")
      expect(fraud.display_text).to eq("Ruby on Rails really, more...")
    end
  end

  describe "#show_status" do
    it "displays Pending when status is 1" do
      fraud = Fabricate(:fraud, status: "1")
      expect(fraud.show_status).to eq("Pending")
    end

    it "displays Go Live when status is 2" do
      fraud = Fabricate(:fraud, status: "2")
      expect(fraud.show_status).to eq("Go Live")
    end

    it "displays Verified when status is 3" do
      fraud = Fabricate(:fraud, status: "3")
      expect(fraud.show_status).to eq("Verified")
    end
  end
end