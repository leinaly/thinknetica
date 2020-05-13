# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :capacity, :occupied

  def initialize(capacity = 100, type = TYPE['freight wagon'])
    super(capacity, type)
  end
end
