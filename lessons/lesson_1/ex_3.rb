=begin
Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет,
является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru),
равнобедренным (т.е. у него равны любые 2 стороны)  или равносторонним (все 3 стороны равны) и выводит результат на экран.
Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза)
и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. Если все 3 стороны равны,
то треугольник равнобедренный и равносторонний, но не прямоугольный.
=end

puts "Enter 3 sides of a triangle separated by a comma: "
tr_array = gets.chomp.split(',').map(&:to_f)
tr_array.sort!.reverse!.map! { |el| el ** 2 }
is_right_tr = (tr_array[0] == tr_array[1] + tr_array[2])
if tr_array.uniq.count == 1 #3,3,3
  puts "This is equilateral triangle (& isosceles triangle as well)"
elsif tr_array.uniq.count == 2 && !is_right_tr #3,3,4
  puts "This is isosceles triangle, but not right triangle"
elsif tr_array.uniq.count == 2 && is_right_tr #4,4,5.658(9)
  puts "This is isosceles triangle (& right triangle as well)"
elsif tr_array.uniq.count > 2 && is_right_tr #3,4,5
  puts "This is right triangle, but not isosceles or equilateral"
else
  puts "This is just ordinary triangle"
end

