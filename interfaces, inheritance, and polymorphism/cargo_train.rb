class CargoTrain < Train
  def initialize(name)
    super
    @type = 'Грузовой поезд'
  end

  def add_car(car)
    super if car.class == CargoCar
  end
end
