class PassengerWagon < Wagon

  attr_reader :seats_count, :occupied

  def initialize(seats_count = 30, type = TYPE["passenger wagon"])
    raise "Seats count can't be blank!" if seats_count.nil?
    super(type)
    @seats_count = seats_count
    @occupied = 0
  end

  def take_seat
    raise "No available seats!" if @seats_count == @occupied
    @occupied += 1
  end

  def available
    @seats_count - @occupied
  end

end

