=begin
Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.
=end

puts "Enter triangle base: "
tr_base = gets.chomp.to_f
puts "Enter triangle height: "
tr_height = gets.chomp.to_f
tr_square = (0.5 * tr_base * tr_height).round(2)
puts "Triangle square: #{tr_square}"
