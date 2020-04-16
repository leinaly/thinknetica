=begin
Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с.
Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)
и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
  Если D > 0, то выводим дискриминант и 2 корня
  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать
Math.sqrt
 Например,
Math.sqrt(16)
  вернет 4, т.е. квадратный корень из 16.
=end

puts "Enter a,b,c of quadratic equation (ах^2 + bx + c = 0) separated by a comma: "
keys_ar = ["a", "b", "c"]
koeff = gets.chomp.split(',').map(&:to_f)
qc_eq = keys_ar.zip(koeff).to_h
#D = (b^2 – 4ac)
qc_eq["D"] = (qc_eq["b"] ** 2 + -1 * 4 * qc_eq["a"] * qc_eq["c"]).round(2)
if qc_eq["D"] < 0 # 45x^2-x+6=0 na
  qc_eq["x1"] = qc_eq["x2"] = "No solution"
elsif qc_eq["D"] == 0 # 4x^2-12x+9=0 1,5
  #-b/2a
  qc_eq["x1"] = qc_eq["x2"] = ((-1 * qc_eq["b"]) / (2 * qc_eq["a"])).round(2)
else # 2x^2+5x-2=0 -2.85/0.35
  #(-b+-sqrt(D))/2a
  sqrt = Math.sqrt(qc_eq["D"])
  qc_eq["x1"] = ((-1 * qc_eq["b"] - sqrt) / (2 * qc_eq["a"])).round(2)
  qc_eq["x2"] = ((-1 * qc_eq["b"] + sqrt) / (2 * qc_eq["a"])).round(2)
end
puts qc_eq

