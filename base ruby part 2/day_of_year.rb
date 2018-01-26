puts 'Введите день'
day = gets.chomp.to_i

puts 'Введите месяц'
month = gets.chomp.to_i

puts 'Введите год'
year = gets.chomp.to_i
  

day_year = 0
usual_year = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}

usual_year.each { |key, val| day_year += val if key < month }

day_year += day

day_year += 1 if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) && month > 2 

puts "#{day}.#{month}.#{year} является #{day_year}-м днем года"
