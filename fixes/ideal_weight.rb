print 'Как вас зовут?'
name = gets.chomp

print 'Какой у вас рост?'
growth = gets.chomp.to_i 

weight = (growth - 110).abs

puts "#{name} ваш идеальный вес #{weight} кг" 
puts 'Ваш вес уже оптимальный' if growth < 110
