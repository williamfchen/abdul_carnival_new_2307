require "./lib/visitor"
require "./lib/ride"

RSpec.describe Ride do
  let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
  let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
  let(:visitor3) { Visitor.new("Penny", 64, "$15") }

  let(:ride1) { Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let(:ride3) { Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling }) }

  describe "#initialize" do
    it "creates a new instance of a Ride object" do
      expect(ride1).to be_a Ride
      expect(Ride).to respond_to(:new).with(1).arguments
    end
  end

  describe "#name" do
    it "has a name and a way to read that data" do
      expect(ride1.name).to eq("Carousel")
      expect(ride1).to_not respond_to(:name=)
    end
  end

  describe "#min_height" do
    it "has a min height and a way to read that data" do
      expect(ride1.min_height).to be 24
      expect(ride1).to_not respond_to(:min_height=)
    end
  end

  describe "#admission_fee" do
    it "has a name and a way to read that data" do
      expect(ride1.admission_fee).to be 1
      expect(ride1).to_not respond_to(:admission_fee=)
    end
  end

  describe "#excitement" do
    it "has a height and a way to read that data" do
      expect(ride1.excitement).to be :gentle
      expect(ride1).to_not respond_to(:excitement=)
    end
  end

  describe "#total_revenue" do
    it "returns the total revenue earned for this ride" do
      expect(ride1.total_revenue).to be 0
      expect(ride1).to_not respond_to(:total_revenue=)
    end
  end

  describe "#rider_log" do
    it "starts out as empty" do
      expect(ride1.rider_log).to be_empty
      expect(ride1).to_not respond_to(:rider_log=)
    end
  end

  context "Boarding Riders" do
    before :each do
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
    end

    describe "#board_rider" do
      it "adds the visitor to the ride's rider log" do
        expect(ride1.rider_log).to match({
          visitor1 => 2,
          visitor2 => 1
        })

        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)

        ride3.board_rider(visitor1)
        ride3.board_rider(visitor2)
        ride3.board_rider(visitor3)

        expect(ride3.rider_log).to match({
          visitor3 => 1
        })
      end

      it "reduces the visitors spending money" do
        expect(visitor1.spending_money).to be 8
        expect(visitor2.spending_money).to be 4

        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)

        ride3.board_rider(visitor1)
        ride3.board_rider(visitor2)
        ride3.board_rider(visitor3)

        expect(visitor1.spending_money).to be 8
        expect(visitor2.spending_money).to be 4
        expect(visitor3.spending_money).to be 13
      end

      it "increases the total revenue earned by this ride" do
        expect(ride1.total_revenue).to be 3

        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)

        ride3.board_rider(visitor1)
        ride3.board_rider(visitor2)
        ride3.board_rider(visitor3)

        expect(ride3.total_revenue).to be 2
      end
    end
  end
end