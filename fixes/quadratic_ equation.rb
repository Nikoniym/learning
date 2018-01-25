puts 'Введите коэффициент a'
a = gets.chomp.to_f
puts 'Введите коэффициент b'
b = gets.chomp.to_f
puts 'Введите коэффициент c'
c = gets.chomp.to_f

d = b**2 - 4 * a * c 

if d > 0
  c = Math.sqrt(d)
  x1 = (-b + c)/(2 * a)
  x2 = (-b - c)/(2 * a)
  puts  "Корени равены x1 = #{x1}, x2 = #{x2}"
else 
  if d == 0
    x1 = -b/(2 * a)
    puts "Корень равен #{x1}"
  else	
    puts 'Корней нет!'
  end
end
