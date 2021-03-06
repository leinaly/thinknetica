require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

=begin
Создать модуль, который позволит указывать название компании-производителя и получать его.
Подключить модуль к классам Вагон и Поезд
В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные на данный момент
Добавить к поезду атрибут Номер (произвольная строка), если его еще нет, который указыватеся при его создании
В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании) и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.

Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:
Методы класса:
       - instances, который возвращает кол-во экземпляров данного класса
Инастанс-методы:
       - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
Подключить этот модуль в классы поезда, маршрута и станции.
Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансев базового класса.
=end
class Main

  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

def menu

  loop do
    puts "1 - Create Station"
    puts "2 - Create Train"
    puts "3 - Create & edit Routes"
    puts "4 - Set Route to Train"
    puts "5 - Add Wagons to Train"
    puts "6 - Remove Wagons from Train"
    puts "7 - Move Train on the Route"
    puts "8 - Show Stations and Trains on Stations"
    puts "0 - if you want to exit"

    print "Enter action number: "
    user_input = gets.chomp.to_i
    break if user_input == 0

    case user_input
      when 1 then create_station
      when 2 then create_train
      when 3 then create_and_edit_route
      when 4 then set_route_to_tr
      when 5 then add_wagons_to_tr
      when 6 then remove_wagons_to_tr
      when 7 then move_train_on_route
      when 8 then show_stations_and_trains
      else puts "I don't know this action!"
    end

  end
  puts "By by!"
end

private #cause no need to show as public interface & created only for internal use in user interface

def create_station
  puts "Enter station name:"
  station_name = gets.chomp
  @stations << Station.new(station_name)
end

def create_train
  puts "What kind of train do you like to create? (freight-fr, passenger-pass)"
  tr_type = gets.chomp.downcase
  puts "Enter train number:"
  tr_number = gets.chomp
  case tr_type
  when "fr"
    @trains << CargoTrain.new(tr_number)
  when "pass"
    @trains << PassengerTrain.new(tr_number)
  else puts "Unknown type of train! Please choose 'fr' or 'pass'"
  end
end

def create_and_edit_route
  if @stations.size > 1
    puts "1 - Create new Route"
    puts "2 - Edit Route"
    user_input = gets.chomp.to_i
    case user_input
    when 1
      create_route
    when 2
      edit_route
    else
      puts "Unknown action with routes! Please choose '1' or '2'"
    end

  end
end

  def show_stations(st = @stations)
    st.each_with_index {|s, i| puts "#{i}-#{s.name}"}
  end

  def show_trains(tr = @trains)
    tr.each_with_index {|t, i| puts "#{i}-#{t.number}"}
  end

  def show_routes(rt = @routes)
    rt.each_with_index {|r, i| puts "#{i}-#{r.stations}"}
  end

  def create_route
    return puts "Need to create at least 2 stations first!" if @stations.count < 2
    puts "Please choose start station:"
    show_stations
    start_station_index = gets.chomp.to_i
    puts "Please choose end station:"
    show_stations
    end_station_index = gets.chomp.to_i
    @routes << Route.new(@stations[start_station_index], @stations[end_station_index])
    show_routes
  end

  def add_station_to_route(route)
    puts "Choose station to add:"
    show_stations
    user_input = gets.chomp.to_i
    return puts "Wrong station index!" if user_input >= @stations.count
    route.add_station(@stations[user_input])

  end

  def delete_station_from_route(route)
      puts "Enter station number for deletion:"
      show_stations(route.stations)
      user_input = gets.chomp.to_i
      return puts "Incorrect number of station!" if user_input>=route.stations.count
      station_to_delete = route.stations[user_input]
      route.delete_station(station_to_delete)
      puts "Route was updated"
  end

  def edit_route
    return puts "Need to create at least 1 route at first!" if @routes.count == 0
    puts "Choose route to edit:"
    show_routes
    route_index = gets.chomp.to_i
    puts "1 - add station to the route"
    puts "2 - delete station from route"
    user_input = gets.chomp.to_i
    case user_input
    when 1
      add_station_to_route(@routes[route_index])
    when 2
      delete_station_from_route(@routes[route_index])
    else
      puts "Unknown action. Please select '1' or '2' "
    end

  end




def set_route_to_tr
  return puts "Need to have one route & one train to perform this action!" if @routes.count==0 || @trains.count==0
  puts "Choose train:"
  show_trains
  user_input = gets.chomp.to_i
  return puts "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  puts "Choose route:"
  show_routes
  user_input = gets.chomp.to_i
  return puts "Incorrect index for route!" if user_input >= @routes.count
  train.set_route(@routes[user_input])
  puts "Route was added"
end

def add_wagons_to_tr
  return puts "Need to create at least 1 train to add wagons to it!" if @trains.count == 0
  puts "Choose train:"
  show_trains
  user_input = gets.chomp.to_i
  return puts "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  train.is_a?(PassengerTrain) ? train.add_wagon(PassengerWagon.new) : train.add_wagon(CargoWagon.new)
end

def remove_wagons_to_tr
  return puts "Need to create at least 1 train to remove wagons to it!" if @trains.count == 0
  puts "Choose train:"
  show_trains
  user_input = gets.chomp.to_i
  return puts "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  return puts "Train have no wagons ! Please choose another one!" if train.wagons.count==0
  train.remove_wagon(train.wagons.last)
  puts "Wagon was deleted"
end

def move_train_on_route
  return puts "Need to have one route & one train to perform this action!" if @routes.count==0 || @trains.count==0
  puts "Choose train:"
  show_trains
  user_input = gets.chomp.to_i
  return puts "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  puts "Choose where to go:"
  puts "1 - move 1 station forward"
  puts "0 - move 1 station back"
  user_input = gets.chomp.to_i
  return "Unknown command!" if user_input<0 && user_input>1
  return "Selected train need to have a route!" if train.route.nil?
  user_input==1 ? train.go_to_next_station : train.go_to_prev_station
  puts "Train on #{train.current_station.name}"
end

def show_stations_and_trains
  @stations.each do |station|
    puts "Station: #{station.name}"
    puts "Trains:"
    show_trains(station.trains)
    puts "<====================================>"
  end
end

end

Main.new.menu
