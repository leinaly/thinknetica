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

COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def is_leap_year?(year)
  year % 4 == 0 or (year % 100 != 0 and year % 400 == 0)
end

puts "Enter date numbers separated by comma (day, month, year): "
keys = %w(d m y)

date_hash = keys.zip(gets.chomp.split(',').map(&:to_i)).to_h
day_number = date_hash["d"]
(1...date_hash["m"]).each { |month| day_number += COMMON_YEAR_DAYS_IN_MONTH[month] }
day_number += 1 if is_leap_year?(date_hash["y"]) and date_hash["m"] > 2

puts "Date: #{date_hash["d"]}, #{date_hash["m"]}, #{date_hash["y"]} | Serial number: #{day_number}"
