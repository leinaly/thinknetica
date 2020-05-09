require_relative 'modules/instance_counter'
require_relative 'modules/company'
require_relative 'modules/validation'

class Train
  include InstanceCounter
  include Company
  include Validation

  @@trains = {}

  attr_reader :number, :type, :wagons, :speed, :route, :current_station

  TYPE = {"freight train" => 0, "passenger train" => 1}
  NUMB_FORMAT = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/i

  def initialize(number, type = TYPE["passenger train"])
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def type_name
    TYPE.key(type)
  end

  def accelerate(step)
    raise "Can accelerate only by numeric value!" unless step.is_a?(Integer)
    raise "Please accelerate with positive value!" if step < 0
    @speed += step
  end

  def slow_down(step = -@speed)
    raise "Can slow down only by numeric value!" unless step.is_a?(Integer)
    raise "Please slow down with negative value!" if step > 0
    raise "Already stopped!" if @speed == 0
    @speed += step
  end

  def set_route(route)
    raise "Can set as route only Route obj!" unless route.is_a?(Route)
    @route = route
    @route.start_station.receive(self)
    @current_station = route.start_station
  end

  def go_to_next_station
    raise "Train already finished route!" if @current_station == @route.end_station
    @current_station.send_train(self)
    raise "No next station! Train already on the last station of the route." if next_station.nil?
    @current_station = next_station
    @current_station.receive(self)
  end

  def go_to_prev_station
    raise "Train already at the start of route!" if @current_station == @route.start_station
    @current_station.send_train(self)
    raise "No previous station! Train already on the first station of the route." if prev_station.nil?
    @current_station = prev_station
    @current_station.receive(self)
  end

  def next_station
    raise "Route not set!" if @route.nil?
    n_st = @route.next_station_for(@current_station)
    n_st = nil if current_station?(n_st)
    n_st
  end

  def prev_station
    raise "Route not set!" unless @route
    p_st = @route.prev_station_for(@current_station)
    p_st = nil if current_station?(p_st)
    p_st
  end

  def each_wagons(block)
    @wagons.each_with_index {|wagon, index| block.call(wagon, index) }
  end

  protected #cause need to be reimplemented in child classes

  def current_station?(station)
    station == @current_station
  end

  def add_wagon(wagon)
    raise "Need to slow down train first!" if speed != 0
    @wagons << wagon
  end

  def remove_wagon(wagon)
    raise "Need to slow down train first!" if speed != 0
    raise "Nothing to remove!" if @wagons.count == 0
    @wagons.delete(wagon)
  end

  private

  def validate!
    raise "Incorrect number length. Must be at least 4 characters!" unless number =~ /.{4}/
    raise "Incorrect number format. Pattern : {...-..}" unless number =~ NUMB_FORMAT
    raise "Not applicable type of train! Need to be from TYPE const: #{TYPE}" unless TYPE.values.include?(type)
  end

end
