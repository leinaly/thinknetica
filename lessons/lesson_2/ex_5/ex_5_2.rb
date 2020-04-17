=begin
5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
(Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
Алгоритм опредления високосного года: www.adm.yar.ru
Год високосный, если он делится на четыре без остатка,
но если он делится на 100 без остатка, это не високосный год.
Однако, если он делится без остатка на 400, это високосный год.
Таким образом, 2000 г. является особым високосным годом, который бывает лишь раз в 400 лет.
=end

require '../lesson_2/ex_1'

# 1 variant
puts "Enter date numbers separated by comma (day, month, year): "
keys = %w(d m y)

date_hash = keys.zip(gets.chomp.split(',').map(&:to_i)).to_h
month_days_hash = fill_months_hash(date_hash["y"], true)
day_number = month_days_hash.fetch_values(*(1...date_hash["m"]).to_a).sum + date_hash["d"]

puts "Date: #{date_hash["d"]}, #{date_hash["m"]}, #{date_hash["y"]} | Serial number: #{day_number}"





