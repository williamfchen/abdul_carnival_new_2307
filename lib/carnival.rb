class Carnival
  attr_reader :duration, :rides

  @@carnival_instances = []

  def initialize(duration)
    @duration = duration
    @rides = []
    @total_rides = Hash.new(0)
    @@carnival_instances << self
  end

  def self.total_revenues
    # Version 1
    @@carnival_instances.sum do |carnival|
      carnival.total_revenue
    end

    # Version 2
    # @@carnival_instances.reduce(0) do |sum, carnival_instance|
    #   sum + carnival_instance.total_revenue 
    # end
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    # Version 1
    # most_rides = 0
    # most_popular = nil

    # @rides.each do |ride|
    #   ride_count = ride.total_revenue / ride.admission_fee
    #   if ride_count > most_rides
    #     most_rides = ride_count
    #     most_popular = ride
    #   end
    # end

    # most_popular

    # Version 2
    # @rides.each do |ride|
    #   @total_rides[ride] = ride.rider_log.values.sum
    # end
    # @total_rides.key(@total_rides.values.max)

    # Version 2
    @rides.max_by do |ride|
      ride.rider_log.values.sum
    end
  end

  def most_profitable_ride
    # Version 1
    @rides.max_by do |ride| 
      ride.total_revenue 
    end

    # Version 2 - Spaceship Operator
    # @rides.max do |ride1, ride2|
    #   ride1.total_revenue <=> ride2.total_revenue
    # end
  end

  def total_revenue
    # Version 1
    # @rides.map do |ride|
    #   ride.total_revenue
    # end.sum

    # Version 2
    # @rides.reduce(0) do |sum, ride| 
    #   sum + ride.total_revenue 
    # end

    # Version 3
    # total_rev = 0
    # @rides.each do |ride|
    #   total_rev += ride.total_revenue
    # end
    # total_rev

    # Version 4
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def summary
    {
      visitor_count: visitors.count,
      revenue_earned: total_revenue,
      visitors: visitors.map do |guest|
        {
          visitor: guest,
          favorite_ride: @rides.max_by { |ride| ride.rider_log[guest] },
          total_money_spent: @rides.map { |ride| ride.rider_log[guest] * ride.admission_fee }.sum
        }
      end,
      rides: @rides.map do |attraction|
        {
          ride: attraction,
          riders: attraction.rider_log.keys,
          total_revenue: attraction.total_revenue
        }
      end
    }
  end

  private

  def visitors
    # Version 1
    # @rides.map do |ride| 
    #   ride.rider_log.keys 
    # end.flatten.uniq

    # Version 2
    @rides.flat_map do |ride|
      ride.rider_log.keys
    end.uniq

    # Version 3
    # @rides.reduce(0) do |sum, ride|
    #   sum += ride.rider_log.keys.count 
    # end
  end

  # def summary
  #   {
  #     visitor_count: visitors.count,
  #     revenue_earned: total_revenue,
  #     visitors: visitors_report,
  #     rides: rides_report,
  #   }
  # end

  # def visitors_report
  #   visitors.map do |visitor|
  #     {
  #       visitor: visitor,
  #       favorite_ride: visitor_favorite_ride(visitor),
  #       total_money_spent: visitor_money_spent(visitor),
  #     }
  #   end
  # end

  # def visitor_favorite_ride(visitor)
  #   @rides.max_by do |ride|
  #     ride.rider_log[visitor]
  #   end
  # end

  # def visitor_money_spent(visitor)
  #   @rides.sum do |ride|
  #     ride.rider_log[visitor] * ride.admission_fee
  #   end
  # end

  # def rides_report
  #   @rides.map do |ride|
  #     {
  #       ride: ride,
  #       riders: ride.rider_log.keys,
  #       total_revenue: ride.total_revenue,
  #     }
  #   end
  # end
end
