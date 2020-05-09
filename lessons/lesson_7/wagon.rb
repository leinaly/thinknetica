require_relative 'modules/company'
require_relative 'modules/validation'

class Wagon
  include Company
  include Validation

  attr_reader :type, :capacity, :occupied

  TYPE = {"freight wagon" => 0, "passenger wagon" => 1}

  def initialize(capacity, type = TYPE["passenger wagon"])
    @type = type
    @capacity = capacity
    @occupied = 0
    validate!
  end

  def type_name
    TYPE.key(type)
  end

  def take_capacity(amount = 1)
    raise "No available capacity!" if @capacity == @occupied
    @occupied += amount
  end

  def available
    @capacity - @occupied
  end

  private

  def validate!
    raise "Not applicable type of train! Need to be from TYPE const: #{TYPE}" unless TYPE.values.include?(type)
    raise "Capacity can't be blank!" if capacity.nil?
  end

end
