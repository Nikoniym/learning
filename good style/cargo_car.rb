class CargoCar
  include ManufacturerName

  def initialize(volume)
    @volume = volume
    @occupied_volume = 0
  end

  def add_volume(volume)
    @occupied_volume += volume if @volume >= @occupied_volume + volume
  end

  attr_reader :occupied_volume

  def free_volume
    @volume - @occupied_volume
  end
end
