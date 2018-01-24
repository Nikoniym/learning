puts 'Введите размер стороны a'
a = gets.chomp.to_i
puts 'Введите размер стороны b'
b = gets.chomp.to_i
puts 'Введите размер стороны c'
c = gets.chomp.to_i
  

if a > b && a > c && a**2 == b**2 + c**2 
	puts "Треугольник прямоугольный #{print 'и равнобедренный' if b == c}"
	elsif   b > a && b > c && b**2 == a**2 + c**2 
		puts "Треугольник прямоугольный #{print 'и равнобедренный' if a == c}"
		elsif  	c > b && c > a && c**2 == a**2 + b**2 
			puts "Треугольник прямоугольный #{print 'и равнобедренный' if b == a}"
			elsif a == b && a == c && c == b 
				puts "Треугольник равносторонний"
				else puts "Не прямоугольный треугольник"
end
