class PassengerTrain < Train
  def initialize(name)
    super
    @type = 'Пассажирский поезд'
  end

  def add_car(car)
    super if car.class == PassengerCar
  end
end
