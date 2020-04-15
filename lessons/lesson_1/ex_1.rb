=begin
  Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле
(<рост> - 110) * 1.15, после чего выводит результат пользователю на экран с обращением по имени.
Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"
=end

puts "Enter your name: "
user_name = gets.chomp
puts "Enter you height: "
user_height = gets.chomp.to_i
ideal_weight = ((user_height - 110) * 1.15).round(2)
positive_decision = "Dear #{user_name}, your ideal weight is - #{ideal_weight}"
negative_decision = "Dear #{user_name}, your weight is already optimal!"
puts ideal_weight < 0 ? negative_decision : positive_decision
