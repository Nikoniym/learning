class Train
  attr_reader :name, :speed, :type, :cars

  def initialize(name)
    @name = name
    @speed = 0
    @cars = []
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

  def add_car(car)
    @cars << car
  end

  def delete_car(action)
    case action
      when 1 then @cars.delete_at(-1)
      when 2 then @cars.delete_at(0)
      else 'Ошибка ввода!!!'
    end
  end
end
