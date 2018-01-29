class Train
  attr_accessor :speed
  attr_reader :name, :type, :count_cars

  def initialize(name, type, count_cars, speed = 0) 
    @name = name
    @type = type
    @count_cars = count_cars
    @speed = speed
  end

  def change_car(change) 
    @speed = 0
    
    @count_cars += 1 if change == '+'
    @count_cars -= 1 if change == '-' && @count_cars != 0 

    puts @count_cars
  end

  def set_route(route)
    @route_position = 0
    @route = route
    
    puts "Установлен маршрут #{route[0]} - #{route[-1]}"
  end

  def change_station(change)
    if !@route_position.nil?

      if change == '+' && (@route.size - 1) > @route_position
        @route_position += 1 
        puts "Текущая станция #{@route[@route_position]}"
      end

      if change == '-' && @route_position != 0 
        @route_position -= 1
        puts "Текущая станция #{@route[@route_position]}"
      end
    else
      puts 'Установите маршрут'
    end
  end

  def position
    if !@route_position.nil?
      puts "Пердыдущая станция #{@route[@route_position - 1]}" if @route_position != 0
      puts "Текущая станция #{@route[@route_position]}"
      puts "Следующая станция #{@route[@route_position + 1]}" if (@route.size - 1) > @route_position
    else
      puts 'Установите маршрут'
    end
  end
end