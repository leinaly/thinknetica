require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class RailRoad

def seed
  prtlnd_station = Station.new("Portland District Station")
  bstn_station   = Station.new("Boston South")
  ny_station     = Station.new("New York Grand Central")
  ph_station     = Station.new("Philadelphia")
  wdc_station    = Station.new("Washington D.C.")

  jcks_station = Station.new("Jacksonville")
  or_station   = Station.new("Orlando")
  tm_station   = Station.new("Tampa")
  mm_station   = Station.new("Miami")


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


  puts "Create train & accelerate"
  south_train = PassengerTrain.new("1234")
  south_train.accelerate(10)
  puts south_train.speed
  south_train.slow_down
  puts south_train.speed
  puts south_train.wagons.count
  pas_wagon = PassengerWagon.new
  south_train.add_wagon(pas_wagon)
  pas_wagon2 = PassengerWagon.new
  south_train.add_wagon(pas_wagon2)
  puts south_train.wagons.count
  south_train.remove_wagon(pas_wagon)
  puts south_train.wagons.count

  south_train.set_route(south_route)
  puts south_train.current_station.name
  south_train.go_to_next_station
  puts south_train.current_station.name
  south_train.go_to_prev_station
  puts south_train.current_station.name

  south_train.current_station.show_all_trains
  south_train.current_station.show_trains_by_type(Train::TYPE["passenger train"])


  north_train = CargoTrain.new("4321")
  puts north_train.accelerate(-10)
  puts north_train.accelerate("more speed")
  puts north_train.speed
  puts north_train.slow_down(-10)
  puts north_train.slow_down("less speed")
  puts north_train.speed

  puts north_train.wagons.count

  car_wagon = CargoWagon.new
  puts north_train.remove_wagon(car_wagon)
  north_train.add_wagon(pas_wagon)
  north_train.add_wagon(car_wagon)
  puts north_train.wagons.count
  puts north_train.remove_wagon(car_wagon)
  puts north_train.wagons.count

  north_train.set_route(north_route)
  puts north_train.current_station.name
  puts north_train.next_station.name
  puts north_train.prev_station

  north_train.go_to_prev_station
  puts north_train.current_station.name
end

end

RailRoad.new.seed
