class Visitor
  attr_reader :height,
              :name,
              :preferences
              
  attr_accessor :spending_money

  def initialize(name, height, spending_money)
    @height = height
    @name = name
    @preferences = []
    @spending_money = spending_money.delete("$").to_i
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(ride_height)
    @height >= ride_height
  end
end