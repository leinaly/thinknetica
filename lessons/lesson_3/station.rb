=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive(train)
    return "Station #{name} can receive only one train at once! Please receive one Train." if train.is_a?(Array)
    @trains << train
  end

  def show_all_trains(trains_to_show = @trains)
    trains_to_show.each.with_index(1) { |train, index| puts "#{index}. #{train.number}" }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_by_type(type = '')
    case type
    when "" then
      show_all_trains
    when Train::TYPE["passenger train"]
      puts "Passenger trains: "; show_all_trains(@trains.select { |train| train.type == Train::TYPE["passenger train"] })
    when Train::TYPE["freight train"]
      puts "Freight trains: "; show_all_trains(@trains.select { |train| train.type == Train::TYPE["freight train"] })
    else
      puts "Sorry, have no idea what type is it."
    end
  end
end
