puts 'Введите размер стороны a'
a = gets.chomp.to_f
puts 'Введите размер стороны b'
b = gets.chomp.to_f
puts 'Введите размер стороны c'
c = gets.chomp.to_f
  
if a > b && a > c
  median = a
  kathetus1 = b
  kathetus2 = c
else
  if b > a && b > c
    median = b
    kathetus1 = a
    kathetus2 = c
  else 
    if c > b && c > a
      median = c
      kathetus1 = a
      kathetus2 = b 
    else
      median = a
      kathetus1 = b
      kathetus2 = c  
    end
  end
end

if median**2 == kathetus1**2 + kathetus2**2
  puts "Треугольник прямоугольный #{print 'и равнобедренный' if kathetus1 == kathetus2}"
else
  if median == kathetus1 && median == kathetus2 && kathetus1 == kathetus2
    puts "Треугольник равносторонний"
  else
    puts "Не прямоугольный треугольник"
  end
end
