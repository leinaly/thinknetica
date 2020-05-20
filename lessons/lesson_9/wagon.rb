# frozen_string_literal: true

require_relative 'modules/company'
require_relative 'modules/validation'

class Wagon
  include Company
  include Validation

  TYPE = { 'freight wagon' => 0, 'passenger wagon' => 1 }

  attr_reader :type, :capacity, :occupied

  validate :capacity, :presence
  validate :type, :speciality, TYPE['passenger wagon']

  def initialize(capacity, type = TYPE['passenger wagon'])
    @type = type
    @capacity = capacity
    @occupied = 0
    validate!
  end

  def type_name
    TYPE.key(type)
  end

  def take_capacity(amount = 1)
    raise 'No available capacity!' if @capacity == @occupied

    @occupied += amount
  end

  def available
    @capacity - @occupied
  end
end
