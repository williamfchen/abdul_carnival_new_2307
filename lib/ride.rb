class Ride
  attr_reader :admission_fee,
              :excitement,
              :min_height,
              :name,
              :rider_log

  def initialize(ride_data)
    @admission_fee = ride_data[:admission_fee]
    @excitement = ride_data[:excitement]
    @min_height = ride_data[:min_height]
    @name = ride_data[:name]
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    if visitor.preferences.include?(@excitement) && visitor.tall_enough?(@min_height)
      @rider_log[visitor] += 1
      visitor.spending_money -= @admission_fee
    end
  end

  def total_revenue
    @rider_log.sum do |_, times_ridden|
      times_ridden * @admission_fee
    end
  end
end
