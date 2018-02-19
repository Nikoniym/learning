class Train
  include Validation
  include ManufacturerName
  extend Accessors

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  attr_reader :number, :speed, :cars

  validate :number, :presence, :format, NUMBER_FORMAT
  validate :speed, :presence, :type, Integer

  attr_accessor_with_history :type, :arg

  strong_attr_acessor :variable_type, String

  @@trains = {}

  def initialize(number)
    @number = number
    @speed = 0
    validate!
    validate_unique!
    @cars = []
    @speed = 0
    @@trains[self.number] = self
    puts "Создан поезд № #{@number}"
    puts "Тип #{(self.is_a? PassengerTrain) ? 'пассажирский' : 'грузовой'}"
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

  def validate_unique!
    raise "Поезд с № #{@number} уже существует!!!" if @@trains.keys.include?(@number)
  end
end
