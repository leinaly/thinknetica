module Formatters
  @@format_wagons = ->(w, i) { puts "#: #{i}-Type: #{w.type_name}-Occupied: #{w.occupied}-Available: #{w.available}" }
  @@format_trains = ->(t, i) { puts "#{i}-#: #{t.number}-Type: #{t.type_name}-Wagons: #{t.wagons.count}" }
  @@format_routes = ->(r, i) { puts "#{i}-#{r.stations}" }
  @@format_stations = ->(s, i) { puts "#{i}-#{s.name}" }
end
