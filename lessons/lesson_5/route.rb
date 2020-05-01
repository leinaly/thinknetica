require_relative 'instance_counter'

class Route

  include InstanceCounter

  attr_reader :intermediate_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    register_instance
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    return puts "Start station can't be deleted! Please choose middle one." if station == @start_station
    return puts "End station can't be deleted! Please choose middle one." if station == @end_station
    @intermediate_stations.delete(station)
  end

  def show_all_stations
    route_str = ""
    stations.each.with_index(1) { |station, index| route_str += "\n#{index}. #{station.name}" }
    puts route_str
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

end
