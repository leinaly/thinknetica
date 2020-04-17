=begin
1. Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы,
у которых количество дней ровно 30
=end
require 'date'


def fill_months_hash(year, numb_keys = false)
  hash_to_fill = {}
  start_date = Date.new(year)
  12.times do
    last_day = start_date.next_month - 1
    hash_to_fill[numb_keys ? last_day.strftime('%m').to_i : last_day.strftime('%B')] = last_day.day
    start_date = start_date >> 1
  end
  hash_to_fill
end

def filter_months(months, number)
  months.select { |m, d| d == number }
end

last_day_of_months = fill_months_hash(2020)
puts filter_months(last_day_of_months, 30)
