class PassengerTrain < Train
  def add_car(car)
    super if car.class == PassengerCar
  end
end
