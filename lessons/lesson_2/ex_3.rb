=begin
3. Заполнить массив числами фибоначчи до 100
=end

#return fib number from sequence by index
def fibonacci(n)
  first, second = [0, 1]
  (n - 1).times do
    first, second = second, first + second
  end
  first
end

#0,1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144
def fill_array(max_number)
  fib_arr = []
  index = 1
  while fibonacci(index) < max_number
    fib_arr << fibonacci(index)
    index += 1
  end
  fib_arr
end

puts fill_array(100)
