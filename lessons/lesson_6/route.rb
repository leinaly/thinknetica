require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Route

  include InstanceCounter
  include Validation

  attr_reader :intermediate_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    validate!
    register_instance
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    raise "Start station can't be deleted! Please choose middle one." if station == @start_station
    raise "End station can't be deleted! Please choose middle one." if station == @end_station
    @intermediate_stations.delete(station)
  end

  def show_all_stations
    route_str = ""
    stations.each.with_index(1) { |station, index| route_str += "\n#{index}. #{station.name}" }
    route_str
  end

  def next_station_for(station)
    stations[station_index(station) + 1] if station_index(station) != stations.count
  end

  def prev_station_for(station)
    stations[station_index(station) - 1] if station_index(station) != 0
  end

  def stations
    [@start_station, @intermediate_stations, @end_station].flatten
  end

  private #because created only for internal use with Route class attributes

  def station_index(station)
    stations.index(station)
  end

  def validate!
    raise "Start and End Stations can't be blank!" if start_station.nil? || end_station.nil?
    raise "Start and End stations can't be equal!" if start_station == end_station
  end

end
