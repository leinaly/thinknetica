class PassengerWagon < Wagon

  def initialize(capacity = 30, type = TYPE["passenger wagon"])
    super(capacity, type)
  end

  alias         seats_count capacity
  alias_method :take_seat, :take_capacity

  def take_capacity(amount)
    super(1)
  end

end

