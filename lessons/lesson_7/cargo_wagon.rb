class CargoWagon < Wagon

  attr_reader :capacity, :occupied

  def initialize(capacity = 100, type = TYPE["freight wagon"])
    raise "Capacity can't be blank!" if capacity.nil?
    super(type)
    @capacity = capacity
    @occupied = 0
  end

  def take_capacity(amount = 1)
    raise "No available capacity!" if @capacity == @occupied
    @occupied += amount
  end

  def available
    @capacity - @occupied
  end

end

