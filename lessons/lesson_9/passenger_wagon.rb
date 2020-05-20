# frozen_string_literal: true

class PassengerWagon < Wagon
  validate :capacity, :presence
  validate :type, :speciality, TYPE['passenger wagon']

  def initialize(capacity = 30, type = TYPE['passenger wagon'])
    super(capacity, type)
  end

  alias seats_count capacity
  alias take_seat take_capacity

  def take_capacity
    super(1)
  end
end
