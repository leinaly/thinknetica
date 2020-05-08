require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'modules/formatters'

=begin

Для пассажирских вагонов:
Добавить атрибут общего кол-ва мест (задается при создании вагона)
Добавить метод, который "занимает места" в вагоне (по одному за раз)
Добавить метод, который возвращает кол-во занятых мест в вагоне
Добавить метод, возвращающий кол-во свободных мест в вагоне.

Для грузовых вагонов:
Добавить атрибут общего объема (задается при создании вагона)
Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
Добавить метод, который возвращает занятый объем
Добавить метод, который возвращает оставшийся (доступный) объем

У класса Station:
написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.

У класса Train:
 написать метод, который принимает блок и проходит по всем вагонам поезда (вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.

Если нет интерфейса, то в отдельном файле, например, main.rb написать код, который:
Создает тестовые данные (станции, поезда, вагоны) и связывает их между собой.
Используя созданные в рамках задания методы, написать код, который перебирает последовательно все станции и для каждой станции выводит список поездов в формате:
      - Номер поезда, тип, кол-во вагонов
   А для каждого поезда на станции выводить список вагонов в формате:
      - Номер вагона (можно назначать автоматически), тип вагона, кол-во свободных и занятых мест (для пассажирского вагона) или кол-во свободного и занятого объема (для грузовых вагонов).

Если у вас есть интерфейс, то добавить возможности:
При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
Выводить список вагонов у поезда (в указанном выше формате), используя созданные методы
Выводить список поездов на станции (в указанном выше формате), используя  созданные методы
Занимать место или объем в вагоне

=end

class Main
  include Formatters
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
    puts "9 - Load Wagon"
    puts "0 - If you want to exit"

    print "Enter action number: "
    user_input = gets.chomp.to_i
    break if user_input == 0

    menu_retry("Try again!") {
    case user_input
      when 1 then create_station
      when 2 then create_train
      when 3 then create_and_edit_route
      when 4 then set_route_to_tr
      when 5 then add_wagons_to_tr
      when 6 then remove_wagons_to_tr
      when 7 then move_train_on_route
      when 8 then show_stations_and_trains
      when 9 then load_wagon
      else puts "I don't know this action!"
    end
    }
  end
  puts "By by!"
end

private #cause no need to show as public interface & created only for internal use in user interface

def create_station
  menu_retry("Station was created") do
    puts "Enter station name:"
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end
end

def create_train
  menu_retry("Train was created"){
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
  }

end

def create_and_edit_route
  if @stations.size >1
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
  else
    raise "Need to create at least 2 stations first!"
  end
end

  def create_route
    menu_retry("Route was created"){
      puts "Please choose start station:"
      show(@stations, @@format_stations)
      start_station_index = gets.chomp.to_i
      puts "please choose end station:"
      show(@stations, @@format_stations)
      end_station_index = gets.chomp.to_i
      @routes << Route.new(@stations[start_station_index], @stations[end_station_index])
      show(@routes, @@format_routes)
    }
end

  def add_station_to_route(route)
    menu_retry("Station was added to route"){
    puts "Choose station to add:"
    show(@stations, @@format_stations)
    user_input = gets.chomp.to_i
    raise "Wrong station index!" if user_input >= @stations.count
    route.add_station(@stations[user_input])
    }
  end

  def delete_station_from_route(route)
    menu_retry("Route was updated"){
      puts "Enter station number for deletion:"
      route.go_through_stations(@@format_stations)
      user_input = gets.chomp.to_i
      raise "Incorrect number of station!" if user_input>=route.stations.count
      station_to_delete = route.stations[user_input]
      route.delete_station(station_to_delete)
    }

  end

  def edit_route
    raise "Need to create at least 1 route at first!" if @routes.count == 0
    puts "Choose route to edit:"
    show(@routes, @@format_routes)
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
  raise "Need to have one route & one train to perform this action!" if @routes.count==0 || @trains.count==0
  menu_retry("Route was added"){
  puts "Choose train:"
  show(@trains, @@format_trains)
  user_input = gets.chomp.to_i
  raise "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  puts "Choose route:"
  show(@routes, @@format_routes)
  user_input = gets.chomp.to_i
  raise "Incorrect index for route!" if user_input >= @routes.count
  train.set_route(@routes[user_input])
  }

end

def add_wagons_to_tr
  raise "Need to create at least 1 train to add wagons to it!" if @trains.count == 0
  menu_retry("Wagon was added to train"){
  puts "Choose train:"
  show(@trains, @@format_trains)
  user_input = gets.chomp.to_i
  raise "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  puts "Enter wagon capacity: "
  capacity = gets.chomp.to_i
  raise "Must be more than zero!" if capacity < 1
  train.is_a?(PassengerTrain) ? train.add_wagon(PassengerWagon.new(capacity)) : train.add_wagon(CargoWagon.new(capacity))
  }
end

def remove_wagons_to_tr
  raise "Need to create at least 1 train to remove wagons to it!" if @trains.count == 0
  menu_retry("Wagon was deleted"){
  puts "Choose train:"
  show(@trains, @@format_trains)
  user_input = gets.chomp.to_i
  raise "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  raise "Train have no wagons ! Please choose another one!" if train.wagons.count==0
  train.remove_wagon(train.wagons.last)
  }
end

def move_train_on_route
  raise "Need to have one route & one train to perform this action!" if @routes.count==0 || @trains.count==0
  menu_retry("Train on #{train.current_station.name}"){
  puts "Choose train:"
  show(@trains, @@format_trains)
  user_input = gets.chomp.to_i
  raise "Incorrect index for train!" if user_input >= @trains.count
  train = @trains[user_input]
  puts "Choose where to go:"
  puts "1 - move 1 station forward"
  puts "0 - move 1 station back"
  user_input = gets.chomp.to_i
  raise "Unknown command!" if user_input<0 && user_input>1
  raise "Selected train need to have a route!" if train.route.nil?
  user_input==1 ? train.go_to_next_station : train.go_to_prev_station
  }
end

def show_stations_and_trains
  @stations.each do |station|
    puts "Station: #{station.name}"
    puts "Trains:"
    station.go_through_trains(@@format_trains)
    puts "<====================================>"
  end
end

  def show(obj_list, block)
    obj_list.each_with_index { |ob, i| block.call(ob,i)}
  end

  def load_wagon
    menu_retry("Wagon was loaded"){
    puts "Choose train:"
    show(@trains, @@format_trains)
    user_input = gets.chomp.to_i
    raise "Incorrect index for train!" if user_input >= @trains.count
    train = @trains[user_input]
    raise "Train have no wagons please add first!" if train.wagons.empty?

    puts "Choose wagon by index:"
    train.go_through_wagons(@@format_wagons)
    wagon_index = user_input = gets.chomp.to_i
    raise "Incorrect index for wagon!" if user_input >= train.wagons.count
    if train.wagons[wagon_index].is_a?(PassengerWagon)
      train.wagons[wagon_index].take_seat
    else
      puts "Enter how much capacity to take: "
      user_input = gets.chomp.to_i
      train.wagons[wagon_index].take_capacity(user_input)
    end
    }

  end

  def menu_retry(success_msg, &block)
    raise "Need to pass block in method!" unless block_given?
    begin
      yield

    rescue RuntimeError => er
      puts er.message
      retry
    end
    puts success_msg
  end

end

Main.new.menu

