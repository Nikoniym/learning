hash = {}
total = 0

loop do 
  puts 'Введите название товара'
  product_name = gets.chomp

  break if product_name == 'стоп'

  puts 'Введите колличество товара'
  count = gets.chomp.to_f

  puts 'Введите цену товара'
  price = gets.chomp.to_f

  hash[product_name] = {price: price, count: count, total: price * count}
  total += price * count  
end

hash.each { |product, group| puts "Товар: #{product} количесво: #{group[:count]} цена: #{group[:price]} итого: #{group[:total]}"}

puts "Итоговая сумма всех покупок: #{total}"
