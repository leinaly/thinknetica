require_relative 'company'

class Wagon
  include Company

  attr_reader :type

  TYPE = {"freight wagon" => 0, "passenger wagon" => 1}

  def initialize(type = TYPE["passenger wagon"])
    @type = type
  end

end
