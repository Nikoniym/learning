class PassengerCar
  include ManufacturerName

  attr_reader :place_count

  def initialize(place_count)
    @place_count = place_count
    @take_place_count = 0
  end

  def take_place
    @take_place_count += 1 if @place_count > @take_place_count
  end

  attr_reader :take_place_count

  def free_place_count
    @place_count - @take_place_count
  end
end
