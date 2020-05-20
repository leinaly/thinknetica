# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :capacity, :occupied

  validate :capacity, :presence
  validate :type, :speciality, TYPE['freight wagon']

  def initialize(capacity = 100, type = TYPE['freight wagon'])
    super(capacity, type)
  end
end
