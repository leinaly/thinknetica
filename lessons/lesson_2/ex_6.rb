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
PRODUCT_PRICE_KEY = "product_price"
PRODUCT_COUNT_KEY = "product_count"
PRODUCT_TOTAL_KEY = "product_total_price"
TOTAL_PRICE_KEY = "total_price"

def calculate_product_total(product)
  product[PRODUCT_TOTAL_KEY] = (product[PRODUCT_PRICE_KEY] * product[PRODUCT_COUNT_KEY]).round(2)
  product
end

def enter_products!(products)
  total_price = 0
  loop do
    product = {}
    puts "Enter product name: "
    product_name = gets.chomp
    break if product_name.downcase == "stop"
    puts "Enter product price: "
    product_price = gets.chomp.to_f
    product[PRODUCT_PRICE_KEY] = product_price
    puts "Enter product amount: "
    product_count = gets.chomp.to_f
    product[PRODUCT_COUNT_KEY] = product_count
    products[product_name] = calculate_product_total(product)
    total_price += product[PRODUCT_TOTAL_KEY]
  end
  products[TOTAL_PRICE_KEY] = total_price.round(2)
  products
end


products = {}
puts "==Entering products started=="

puts enter_products!(products)

puts "==Entering products finished=="

puts "Total basket price: #{products[TOTAL_PRICE_KEY]}"


