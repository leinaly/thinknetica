=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = []
  end

  def add_station(station)
    @stations << station
  end

  def delete_station(station)
    return "Start station can't be deleted! Please choose middle one." if station == @start_station
    return "End station can't be deleted! Please choose middle one." if station == @end_station
    stations.delete(station)
  end

  def show_all_stations
    route_str = "1. #{@start_station.name}"
    @stations.each.with_index(2) { |station, index| route_str += "\n#{index}. #{station.name}" }
    route_str += "\n#{stations.size + 2}. #{@end_station.name}\n"
    puts route_str
  end

  def next_station_for(station)
    case station
    when @start_station
      @stations.first
    when @end_station
      @end_station
    else
      current_index = @stations.find_index { |el| el.name == station.name }
      current_index == @stations.size - 1 ? @end_station : @stations[current_index + 1]
    end
  end

  def prev_station_for(station)
    case station
    when @start_station
      @start_station
    when @end_station
      @stations.last
    else
      current_index = @stations.find_index { |el| el.name == station.name }
      current_index == 0 ? @start_station : @stations[current_index - 1]
    end
  end

end
