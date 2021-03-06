class Train
  attr_reader :number, :type, :wagons, :speed, :route, :current_station

  TYPE = {"freight train" => 0, "passenger train" => 1}

  def initialize(number, type = TYPE["passenger train"])
    @number = number
    return puts "Not applicable type of train! Need to be from TYPE const: #{TYPE}" unless TYPE.values.include?(type)
    @type = type
    @wagons = []
    @speed = 0
  end

  def accelerate(step)
    return puts "Can accelerate only by numeric value!" unless step.is_a?(Integer)
    return puts "Please accelerate with positive value!" if step < 0
    @speed += step
  end

  def slow_down(step = -@speed)
    return puts "Can slow down only by numeric value!" unless step.is_a?(Integer)
    return puts "Please slow down with negative value!" if step > 0
    return puts "Already stopped!" if @speed == 0
    @speed += step
  end

  def set_route(route)
    return puts "Can set as route only Route obj!" unless route.is_a?(Route)
    @route = route
    @route.start_station.receive(self)
    @current_station = route.start_station
  end

  def go_to_next_station
    return puts "Train already finished route!" if @current_station == @route.end_station
    @current_station.send_train(self)
    return puts "No next station! Train already on the last station of the route." if next_station.nil?
    @current_station = next_station
    @current_station.receive(self)
  end

  def go_to_prev_station
    return puts "Train already at the start of route!" if @current_station == @route.start_station
    @current_station.send_train(self)
    return puts "No previous station! Train already on the first station of the route." if prev_station.nil?
    @current_station = prev_station
    @current_station.receive(self)
  end

  def next_station
    return puts "Route not set!" if @route.nil?
    n_st = @route.next_station_for(@current_station)
    n_st = nil if current_station?(n_st)
    n_st
  end

  def prev_station
    return puts "Route not set!" unless @route
    p_st = @route.prev_station_for(@current_station)
    p_st = nil if current_station?(p_st)
    p_st
  end

  protected #cause need to be reimplemented in child classes

  def current_station?(station)
    station == @current_station
  end

  def add_wagon(wagon)
    return puts "Need to slow down train first!" if speed != 0
    @wagons << wagon
  end

  def remove_wagon(wagon)
    return puts "Need to slow down train first!" if speed != 0
    return puts "Nothing to remove!" if @wagons.count == 0
    @wagons.delete(wagon)
  end

end
