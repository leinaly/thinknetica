=begin
4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

vowels_arr = %w(a e i o u)
vowels_hash = {}
('a'..'z').to_a.each_with_index { |el, index| vowels_hash[el] = index + 1 if vowels_arr.include?(el) }
puts vowels_hash