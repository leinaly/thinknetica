=begin
4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

vowels_arr = %w(a e i o u)
vowels_hash = {}
('a'..'z').each.with_index(1) { |el, index| vowels_hash[el] = index if vowels_arr.include?(el) }
puts vowels_hash
