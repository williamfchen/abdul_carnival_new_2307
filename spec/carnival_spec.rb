require "./lib/visitor"
require "./lib/ride"
require "./lib/carnival"

RSpec.describe Carnival do
  let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
  let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
  let(:visitor3) { Visitor.new("Penny", 64, "$15") }

  let(:ride1) { Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let(:ride3) { Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling }) }

  let(:carnival1) { Carnival.new(14) }

  describe "#initialize" do
    it "creates a new instance of a Carnival object" do
      expect(carnival1).to be_a Carnival
      expect(Carnival).to respond_to(:new).with(1).arguments
    end
  end

  describe "#duration" do
    it "has a duration and a way to read that data" do
      expect(carnival1.duration).to be 14
      expect(carnival1).to_not respond_to(:duration=)
      expect(carnival1).not_to respond_to(:duration=)
    end
  end

  describe "#rides" do
    it "starts out with no rides" do
      expect(carnival1.rides).to be_empty
    end
  end

  describe "#add_ride" do
    it "can add rides to to the carnival" do
      carnival1.add_ride(ride1)

      expect(carnival1.rides).to match([ride1])

      carnival1.add_ride(ride2)

      expect(carnival1.rides).to match([ride1, ride2])

      carnival1.add_ride(ride3)

      expect(carnival1.rides).to match([ride1, ride2, ride3])
    end
  end

  describe "#most_popular_ride" do
    it "returns the ride that has been ridden the most amount of times by all visitors (not based on unique riders)" do
      # let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
      # let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
      # let(:visitor3) { Visitor.new("Penny", 64, "$15") }

      # let(:ride1) { Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle }) }
      # let(:ride2) { Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle }) }
      # let(:ride3) { Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling }) }

      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival1.most_popular_ride).to eq(ride1)

      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival1.most_popular_ride).to eq(ride3)
    end
  end

  describe "#most_profitable_ride" do
    it "returns the ride that has generated to most revenue" do
      # let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
      # let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
      # let(:visitor3) { Visitor.new("Penny", 64, "$15") }

      # let(:ride1) { Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle }) }
      # let(:ride2) { Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle }) }
      # let(:ride3) { Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling }) }

      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      ride2.board_rider(visitor1)

      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival1.most_profitable_ride).to eq(ride2)

      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival1.most_profitable_ride).to eq(ride3)
    end
  end

  describe "#total_revenue" do
    it "returns the ride that has generated to most revenue" do
      # let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
      # let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
      # let(:visitor3) { Visitor.new("Penny", 64, "$15") }

      # let(:ride1) { Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle }) }
      # let(:ride2) { Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle }) }
      # let(:ride3) { Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling }) }

      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      ride2.board_rider(visitor1)

      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival1.total_revenue).to be 10

      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival1.total_revenue).to be 16
    end
  end

  describe "#summary" do
    it "returns a summary hash for the carnival" do
      # let(:visitor1) { Visitor.new("Bruce", 54, "$10") }
      # let(:visitor2) { Visitor.new("Tucker", 36, "$5") }
      # let(:visitor3) { Visitor.new("Penny", 64, "$15") }

      # let(:ride1) { Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle }) }
      # let(:ride2) { Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle }) }
      # let(:ride3) { Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling }) }

      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      ride2.board_rider(visitor1)

      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival1.summary).to match({
        visitor_count: 3,
        revenue_earned: 16,
        visitors: [
          {
            visitor: visitor1,
            favorite_ride: ride1,
            total_money_spent: 7,
          },
          {
            visitor: visitor2,
            favorite_ride: ride1,
            total_money_spent: 1,
          },
          {
            visitor: visitor3,
            favorite_ride: ride3,
            total_money_spent: 8,
          },
        ],
        rides: [
          {
            ride: ride1,
            riders: [visitor1, visitor2],
            total_revenue: 3,
          },
          {
            ride: ride2,
            riders: [visitor1],
            total_revenue: 5,
          },
          {
            ride: ride3,
            riders: [visitor3],
            total_revenue: 8,
          },
        ],
      })
    end
  end

  describe "::total_revenues" do
    before :each do
      # Need to reset the @@carnival_instances class variable to be empty
      Carnival.class_variable_set(:@@carnival_instances, [])
    end

    it "can calculate the total revenue of all carnivals" do
      # Carnival 1
      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      ride2.board_rider(visitor1)

      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)

      # Carnival 2
      carnival2 = Carnival.new(21)

      ride4 = Ride.new({ name: "Carousel", min_height: 24, admission_fee: 1, excitement: :gentle })
      ride5 = Ride.new({ name: "Ferris Wheel", min_height: 36, admission_fee: 5, excitement: :gentle })
      ride6 = Ride.new({ name: "Roller Coaster", min_height: 54, admission_fee: 2, excitement: :thrilling })

      visitor4 = Visitor.new("Bruce", 54, "$10")
      visitor5 = Visitor.new("Tucker", 36, "$5")
      visitor6 = Visitor.new("Penny", 64, "$15")

      carnival2.add_ride(ride4)
      carnival2.add_ride(ride5)
      carnival2.add_ride(ride6)

      visitor4.add_preference(:gentle)
      visitor4.add_preference(:thrilling)
      visitor5.add_preference(:gentle)
      visitor5.add_preference(:thrilling)
      visitor6.add_preference(:gentle)
      visitor6.add_preference(:thrilling)

      ride4.board_rider(visitor4)
      ride4.board_rider(visitor5)
      ride4.board_rider(visitor4)

      ride5.board_rider(visitor4)
      ride5.board_rider(visitor5)

      ride6.board_rider(visitor4)
      ride6.board_rider(visitor5)
      ride6.board_rider(visitor6)
      ride6.board_rider(visitor6)

      expect(Carnival.total_revenues).to be 35
    end
  end
end