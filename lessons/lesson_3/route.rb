=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :intermediate_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    return "Start station can't be deleted! Please choose middle one." if station == @start_station
    return "End station can't be deleted! Please choose middle one." if station == @end_station
    @intermediate_stations.delete(station)
  end

  def stations
    [@start_station, @intermediate_stations, @end_station].flatten
  end

  def station_index(station)
    stations.index(station)
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

end
