=begin
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны
(по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
 Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  attr_reader :number
  attr_reader :type
  attr_reader :wagons_count
  attr_reader :speed
  attr_reader :route
  attr_reader :current_station

  TYPE = {"freight train" => 0, "passenger train" => 1}

  def initialize(number, wagons_count, type = TYPE["passenger train"])
    @number = number
    return "Not applicable type of train! Need to be from TYPE const: #{TYPE}" unless TYPE.values.include?(type)
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def accelerate(step)
    return "Can accelerate only by numeric value!" unless step.is_a?(Integer)
    return "Please accelerate with positive value!" if step < 0
    @speed += step
  end

  def slow_down(step = -@speed)
    return "Can slow down only by numeric value!" unless step.is_a?(Integer)
    return "Please slow down with negative value!" if step > 0
    return "Already stopped!" if @speed == 0
    @speed += step
  end

  def add_wagon
    return "Need to slow down train first!" if speed != 0
    @wagons_count += 1
  end

  def remove_wagon
    return "Need to slow down train first!" if speed != 0
    return "Nothing to remove!" if @wagons_count == 0
    @wagons_count -= 1
  end

  def set_route(route)
    return "Can set as route only Route obj!" unless route.is_a?(Route)
    @route = route
    @route.start_station.receive(self)
    @current_station = route.start_station
  end

  def go_to_next_station
    return "Train already finished route!" if @current_station == @route.end_station
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.receive(self)
  end

  def go_to_prev_station
    return "Train already at the start of route!" if @current_station == @route.start_station
    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.receive(self)
  end

  def next_station
    return "Route not set!" if @route.nil?
    n_st = @route.next_station_for(@current_station)
    return "No next station! Train already on the last station of the route." if n_st.name == @current_station.name
    n_st
  end

  def prev_station
    return "Route not set!" if @route.nil?
    p_st = @route.prev_station_for(@current_station)
    return "No previous station! Train already on the first station of the route." if p_st.name == @current_station.name
    p_st
  end
end
