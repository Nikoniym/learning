puts 'Введите коэффициент a'
a = gets.chomp.to_i
puts 'Введите коэффициент b'
b = gets.chomp.to_i
puts 'Введите коэффициент c'
c = gets.chomp.to_i

d = b**2 - 4*a*c 

if d > 0
	c = Math.sqrt(d)
	x1 = ((-b + c)/(2*a)).to_f
	x2 = ((-b - c)/(2*a)).to_f
	puts  "Корени равены x1 = #{x1}, x2 = #{x2}"
elsif d == 0
	x1 = -b/(2*a).to_f
	puts "Корень равен #{x1}"
	else	puts 'Корней нет!'
end
	 
