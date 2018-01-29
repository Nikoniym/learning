class Train
  attr_accessor :speed, :route
  attr_reader :name, :type, :count_cars

  def initialize(name, type, count_cars, speed = 0) 
    @name = name
    @type = type
    @count_cars = count_cars
    @speed = speed
    @route_position = 0    
  end

  def add_car 
    @speed = 0    
    @count_cars += 1     
    puts @count_cars
  end

  def delete_car 
    @speed = 0
    @count_cars -= 1 if @count_cars != 0
    puts @count_cars
  end

  # def set_route
  #   if @route    
  #     @route_position = 0
  #     puts "Установлен маршрут #{@route.name}"
  #   else
  #     puts 'Утановите маршрут!'
  # end

  def next_station
    if @route
      if (@route.stations.size - 1) > @route_position
        @route_position += 1 
        puts "Текущая станция #{@route.stations[@route_position].name}"
      end
    else
      puts 'Установите маршрут'
    end
  end

  def prev_station
    if @route
      if  @route_position != 0 
        @route_position -= 1
        puts "Текущая станция #{@route.stations[@route_position].name}"
      end
    else
      puts 'Установите маршрут'
    end
  end

  def position
    if @route
      puts "Пердыдущая станция #{@route.stations[@route_position - 1].name}" if @route_position != 0
      puts "Текущая станция #{@route.stations[@route_position].name}"
      puts "Следующая станция #{@route.stations[@route_position + 1].name}" if (@route.stations.size - 1) > @route_position
    else
      puts 'Установите маршрут'
    end
  end
end