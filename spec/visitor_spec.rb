require "./lib/visitor"

RSpec.describe Visitor do
  let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
  let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
  let(:visitor3) { Visitor.new("Penny", 64, "$15") }

  describe "#initialize" do
    it "creates a new instance of a Visitor object" do
      expect(visitor1).to be_a Visitor
      expect(Visitor).to respond_to(:new).with(3).arguments
    end
  end

  describe "#name" do
    it "has a name and a way to read that data" do
      expect(visitor1.name).to eq("Bruce")
      expect(visitor1).to_not respond_to(:name=)
    end
  end

  describe "#height" do
    it "has a height and a way to read that data" do
      expect(visitor1.height).to be 54
      expect(visitor1).to_not respond_to(:height=)
    end
  end

  describe "#spending_money" do
    it "has spending money and a way to read that data" do
      expect(visitor1.spending_money).to be 10
      expect(visitor1.spending_money).to be_an Integer
      expect(visitor1).to respond_to(:spending_money=)
    end
  end

  describe "#preferences" do
    it "has preferences and a way to read that data" do
      expect(visitor1.preferences).to be_empty
      expect(visitor1).to_not respond_to(:preferences=)
    end
  end

  describe "#add_preference" do
    it "can preferences to the visitors list of ride preferences" do
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:thrilling)

      expect(visitor1.preferences).to match([:gentle, :thrilling])
    end
  end

  describe "#tall_enough?" do
    it "returns true or false for whether a visitor is tall enough for rides based on a given height threshold" do
      expect(visitor1.tall_enough?(54)).to be true
      expect(visitor2.tall_enough?(54)).to be false
      expect(visitor3.tall_enough?(54)).to be true
      expect(visitor1.tall_enough?(64)).to be false
    end
  end
end