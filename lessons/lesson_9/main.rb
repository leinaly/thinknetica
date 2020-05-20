# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'modules/formatters'

#
# Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать на уровне класса:
#
# метод
# attr_accessor_with_history
#
#  Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов, при этом сеттер сохраняет
# все значения инстанс-переменной при изменении этого значения.
# Также в класс, в который подключается модуль должен добавляться инстанс-метод
# <имя_атрибута>_history
#
#   который возвращает массив всех значений данной переменной.
#
# метод
# strong_attr_accessor
#
#  который принимает имя атрибута и его класс. При этом создается геттер и сеттер для одноименной инстанс-переменной,
# но сеттер проверяет тип присваемоего значения. Если тип отличается от того, который указан вторым параметром, то
# выбрасывается исключение. Если тип совпадает, то значение присваивается.
#
# Написать модуль Validation, который:
#
# Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута, а также тип
# валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
#    - presence - требует, чтобы значение атрибута было не nil и не пустой строкой. Пример использования:
#
# validate :name, :presence
#
#
#   - format (при этом отдельным параметром задается регулярное выражение для формата). Треубет соответствия значения
# атрибута заданному регулярному выражению. Пример:
# validate :number, :format, /A-Z{0,3}/
#
#
#  - type (третий параметр - класс атрибута). Требует соответствия значения атрибута заданному классу. Пример:
#
#
# validate :station, :type, RailwayStation
#
#  Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса
# validate. В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
# Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false,
# если есть ошибки валидации.
# К любому атрибуту можно применить несколько разных валидаторов, например
# validate :name, :presence
# validate :name, :format, /A-Z/
# validate :name, :type, String
#  Все указанные валидаторы должны применяться к атрибуту
# Допустимо, что модуль не будет работать с наследниками.
#
# Подключить эти модули в свои классы и продемонстрировать их использование. Валидации заменить на методы из
# модуля Validation.
#

class Main
  include Formatters
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def test_meta
    test_train = CargoTrain.new('100-22')
    puts test_train.speed.to_s
    test_train.accelerate(10)
    puts test_train.speed.to_s
    test_train.slow_down(-5)
    puts test_train.speed.to_s
    test_train.accelerate(15)
    puts test_train.speed.to_s

    puts "Historical speed: #{test_train.speed_history}"

    prtlnd_station = Station.new('Portland District Station')
    wdc_station    = Station.new('Washington D.C.')

    north_route = Route.new(prtlnd_station, wdc_station)
    test_train.add_route(north_route)
    begin
      test_train.add_route(wdc_station)
    rescue TypeError => e
      puts "Accessor module validation works. Msg: #{e.message}"
    end

    begin
      Train.new(nil)
    rescue RuntimeError => e
      puts "Validation module works. Msg: #{e.message}"
    end
  end

  private # cause no need to show as public interface & created only for internal use in user interface

  def create_station
    menu_retry('Station was created') do
      puts 'Enter station name:'
      station_name = gets.chomp
      @stations << Station.new(station_name)
    end
  end

  def create_train
    menu_retry('Train was created') do
      puts 'What kind of train do you like to create? (freight-fr, passenger-pass)'
      tr_type = gets.chomp.downcase
      puts 'Enter train number:'
      tr_number = gets.chomp

      case tr_type
      when 'fr'
        @trains << CargoTrain.new(tr_number)
      when 'pass'
        @trains << PassengerTrain.new(tr_number)
      else
        puts "Unknown type of train! Please choose 'fr' or 'pass'"
      end
    end
  end

  def create_and_edit_route
    raise 'Need to create at least 2 stations first!' unless @stations.size > 1

    puts '1 - Create new Route'
    puts '2 - Edit Route'
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

  def create_route
    menu_retry('Route was created') do
      puts 'Please choose start station:'
      show(@stations, @@format_stations)
      start_station_index = gets.chomp.to_i
      puts 'please choose end station:'
      show(@stations, @@format_stations)
      end_station_index = gets.chomp.to_i
      @routes << Route.new(@stations[start_station_index], @stations[end_station_index])
      show(@routes, @@format_routes)
    end
  end

  def add_station_to_route(route)
    menu_retry('Station was added to route') do
      puts 'Choose station to add:'
      show(@stations, @@format_stations)
      user_input = gets.chomp.to_i
      raise 'Wrong station index!' if user_input >= @stations.count

      route.add_station(@stations[user_input])
    end
  end

  def delete_station_from_route(route)
    menu_retry('Route was updated') do
      puts 'Enter station number for deletion:'
      route.each_stations(@@format_stations)
      user_input = gets.chomp.to_i
      raise 'Incorrect number of station!' if user_input >= route.stations.count

      station_to_delete = route.stations[user_input]
      route.delete_station(station_to_delete)
    end
  end

  def edit_route
    raise 'Need to create at least 1 route at first!' if @routes.zero?

    puts 'Choose route to edit:'
    show(@routes, @@format_routes)
    route_index = gets.chomp.to_i
    puts '1 - add station to the route'
    puts '2 - delete station from route'
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

  def choose_train
    puts 'Choose train:'
    show(@trains, @@format_trains)
    user_input = gets.chomp.to_i
    raise 'Incorrect index for train!' if user_input >= @trains.count

    @trains[user_input]
  end

  def set_route_to_tr
    raise 'Need to have one route & one train to perform this action!' if @routes.zero? || @trains.zero?

    menu_retry('Route was added') do
      train = choose_train
      puts 'Choose route:'
      show(@routes, @@format_routes)
      user_input = gets.chomp.to_i
      raise 'Incorrect index for route!' if user_input >= @routes.count

      train.add_route(@routes[user_input])
    end
  end

  def add_wagons_to_tr
    raise 'Need to create at least 1 train to add wagons to it!' if @trains.zero?

    menu_retry('Wagon was added to train') do
      train = choose_train
      puts 'Enter wagon capacity: '
      capacity = gets.chomp.to_i
      raise 'Must be more than zero!' if capacity < 1

      train.is_a?(PassengerTrain) ? train.add_wagon(PassengerWagon.new(capacity)) : train.add_wagon(CargoWagon.new(capacity))
    end
  end

  def remove_wagons_to_tr
    raise 'Need to create at least 1 train to remove wagons to it!' if @trains.zero?

    menu_retry('Wagon was deleted') do
      train = choose_train
      raise 'Train have no wagons ! Please choose another one!' if train.wagons.count.zero?

      train.remove_wagon(train.wagons.last)
    end
  end

  def move_train_on_route
    raise 'Need to have one route & one train to perform this action!' if @routes.zero? || @trains.zero?

    menu_retry('Train was moved') do
      train = choose_train
      puts 'Choose where to go:'
      puts '1 - move 1 station forward'
      puts '0 - move 1 station back'
      user_input = gets.chomp.to_i
      raise 'Unknown command!' if user_input.negative? && user_input > 1
      raise 'Selected train need to have a route!' if train.route.nil?

      user_input == 1 ? train.go_to_next_station : train.go_to_prev_station
    end
  end

  def show_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.name}"
      puts 'Trains:'
      station.each_train(@@format_trains)
      # station.go_through_trains(@@format_trains)
      puts '<====================================>'
    end
  end

  def show(obj_list, block)
    obj_list.each_with_index { |ob, i| block.call(ob, i) }
  end

  def load_wagon
    menu_retry('Wagon was loaded') do
      train = choose_train
      raise 'Train have no wagons please add first!' if train.wagons.empty?

      puts 'Choose wagon by index:'
      train.each_wagon(@@format_wagons)
      user_input = gets.chomp.to_i
      raise 'Incorrect index for wagon!' if user_input >= train.wagons.count

      if train.wagons[user_input].is_a?(PassengerWagon)
        train.wagons[user_input].take_seat
      else
        puts 'Enter how much capacity to take: '
        capacity = gets.chomp.to_i
        raise "Capacity can't be less than 0!" if capacity.negative?

        train.wagons[user_input].take_capacity(capacity)
      end
    end
  end

  def menu_retry(success_msg)
    raise 'Need to pass block in method!' unless block_given?

    begin
      yield
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts success_msg
  end
end

Main.new.test_meta
