require_relative 'modules/company'

class Wagon
  include Company

  attr_reader :type

  TYPE = {"freight wagon" => 0, "passenger wagon" => 1}

  def initialize(type = TYPE["passenger wagon"])
    @type = type
    validate!
  end

  def valid?
      validate!
      true
    rescue
      false
  end

  private

  def validate!
    raise "Not applicable type of train! Need to be from TYPE const: #{TYPE}" unless TYPE.values.include?(type)
  end

end
