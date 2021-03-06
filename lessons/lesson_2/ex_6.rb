=begin
6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
(может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп"
в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
содержащий цену за единицу товара и кол-во купленного товара.
Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

# {"product_name" => {"product_price"=> price, "product_count"=> count, "product_total_price"=> pr_total}, "total_price"=>total}

def calculate_product_total(product)
  product[PRODUCT_TOTAL_KEY] = (product[PRODUCT_PRICE_KEY] * product[PRODUCT_COUNT_KEY]).round(2)
  product
end

def enter_products
  products = {}
  loop do
    product = {}
    puts "Enter product name: "
    product_name = gets.chomp
    break if product_name.downcase == "stop"
    puts "Enter product price: "
    product_price = gets.chomp.to_f
    product[:product_price] = product_price
    puts "Enter product amount: "
    product_count = gets.chomp.to_f
    product[:product_count] = product_count
    products[product_name] = product
  end
  products
end

def calculate_totals!(products)
  total_price = 0
  products.each do |product_name, product_info|
    products[product_name] = calculate_product_total(product_info)
    total_price += product_info[:product_total_price]
  end
  products[:total_price] = total_price.round(2)
  products
end

puts "==Entering products started=="

products = enter_products
puts calculate_totals!(products)

puts "==Entering products finished=="

puts "Total basket price: #{products[:total_price]}"
