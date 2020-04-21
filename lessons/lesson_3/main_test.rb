require '../lesson_3/route'
require '../lesson_3/station'
require '../lesson_3/train'

=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

prtlnd_station = Station.new("Portland District Station")
bstn_station = Station.new("Boston South")
ny_station = Station.new("New York Grand Central")
ph_station = Station.new("Philadelphia")
wdc_station = Station.new("Washington D.C.")

jcks_station = Station.new("Jacksonville")
or_station = Station.new("Orlando")
tm_station = Station.new("Tampa")
mm_station = Station.new("Miami")

=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

#north obj for checking exceptions situations
north_route = Route.new(prtlnd_station, wdc_station)
north_route.add_station(bstn_station)
north_route.add_station(ny_station)
north_route.add_station(ph_station)

puts "North Route: "
north_route.show_all_stations
puts ""

#south obj for checking specification
south_route = Route.new(jcks_station, mm_station)
south_route.add_station(or_station)
south_route.add_station(tm_station)

puts "South Route: "
south_route.show_all_stations

puts "Tried to delete"
puts north_route.delete_station(prtlnd_station)
puts north_route.delete_station(wdc_station)
north_route.show_all_stations
puts ""
south_route.delete_station(or_station)
south_route.show_all_stations
puts ""
south_route.add_station(or_station)
south_route.show_all_stations

=begin
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

puts "Create train & accelerate"
south_train = Train.new("1234", 4)
south_train.accelerate(10)
puts south_train.speed
south_train.slow_down
puts south_train.speed
puts south_train.wagons_count
south_train.add_wagon
puts south_train.wagons_count
south_train.remove_wagon
puts south_train.wagons_count

south_train.set_route(south_route)
puts south_train.current_station.name
south_train.go_to_next_station
puts south_train.current_station.name
south_train.go_to_prev_station
puts south_train.current_station.name

south_train.current_station.show_all_trains
south_train.current_station.show_trains_by_type(Train::TYPE["passenger train"])


north_train = Train.new("4321", 1, Train::TYPE["freight train"])
puts north_train.accelerate(-10)
puts north_train.accelerate("more speed")
puts north_train.speed
puts north_train.slow_down(-10)
puts north_train.slow_down("less speed")
puts north_train.speed

puts north_train.wagons_count
puts north_train.remove_wagon
puts north_train.wagons_count
puts north_train.remove_wagon

north_train.set_route(north_route)
puts north_train.current_station.name
puts north_train.next_station.name
puts north_train.prev_station

