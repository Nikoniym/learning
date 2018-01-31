class Train
  attr_reader :name, :type, :count_cars, :speed

  def initialize(name, type, count_cars, speed = 0)
    @name = name
    @type = type
    @count_cars = count_cars
    @speed = speed
  end

  def add_car
    @speed = 0
    @count_cars += 1
  end

  def delete_car
    @speed = 0
    @count_cars -= 1 if @count_cars != 0
  end

  def add_speed(speed)
    @speed += speed
  end

  def reduce_speed(speed)
    @speed -= speed if @speed >= speed
  end

  def stop
    @speed = 0
  end

  def set_route(route)
    @route = route
    @route_position = 0
    @route.stations[0].add_train(self)
    puts "Установлен маршрут #{@route.name}"
  end

  def go_next_station
    if @route && (@route.stations.size - 1) > @route_position
        @route.stations[@route_position].send_train(self)
        @route_position += 1
        @route.stations[@route_position].add_train(self)
        puts "Текущая станция #{@route.stations[@route_position].name}"
    end
  end

  def go_prev_station
    if @route && @route_position != 0
        @route.stations[@route_position].send_train(self)
        @route_position -= 1
        @route.stations[@route_position].add_train(self)
        puts "Текущая станция #{@route.stations[@route_position].name}"
    end
  end

  def current_station
    if @route
      @route.stations[@route_position]
    else
      puts 'Установите маршрут'
    end
  end

  def show_next_station
    if @route && (@route.stations.size - 1) > @route_position
      @route.stations[@route_position + 1]
    end
  end

  def show_prev_station
    if @route && @route_position != 0
       @route.stations[@route_position - 1]
    end
  end
end
