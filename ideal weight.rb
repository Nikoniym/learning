print 'Какой вас зовут?'
name = gets.chomp

print 'Какой у вас рост?'
growth = gets.chomp.to_i - 110

puts "#{name} ваш идеальный вес #{growth} кг" 
puts 'Ваш вес уже оптимальный' if growth < 0
