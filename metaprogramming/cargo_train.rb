class CargoTrain < Train
  def add_car(car)
    super if car.class == CargoCar
  end
end
