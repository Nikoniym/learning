class Train
  include Validation
  include ManufacturerName

  attr_reader :number, :speed, :cars

  @@trains = {}

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @cars = []
    @speed = 0
    @@trains[self.number] = self
    puts "Создан поезд № #{@number}"
    puts "Тип #{self.is_a? PassengerTrain ? 'пассажирский' : 'грузовой'}"
  end

  def each_cars
    @cars.each.with_index(1) { |car, index| yield(car, index) }
  end

  def self.find(number)
    @@trains[number]
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

  def seting_route(route)
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
    if @route && @route_position.nonzero?
      @route.stations[@route_position].send_train(self)
      @route_position -= 1
      @route.stations[@route_position].add_train(self)
      puts "Текущая станция #{@route.stations[@route_position].name}"
    end
  end

  def add_car(car)
    @cars << car
  end

  def delete_car(car)
    @cars.delete(car)
    puts 'Вагон отцеплен'
  end

  private

  def validate!
    raise 'Допустимый формат: XXX-XX' if @number !~ NUMBER_FORMAT
    raise "Поезд с № #{@number} уже существует!!!" if @@trains.keys.include?(@number)
    raise 'Поле номер поезда не может быть пустым' if @number.empty?
    true
  end
end
