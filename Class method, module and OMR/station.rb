class Station
  include InstanceCounter
  attr_reader :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@stations << self
  end

  def self.all_stations
    @@stations
  end

  def add_train(train)
    if !@trains.include?(train)
      @trains << train
    else
      puts "Поезд с № #{train.name} уже на станции"
    end
  end

  def send_train(train)
    @trains.delete(train)
  end

  def list_trains
    @trains.each { |train| puts "Поезд № #{train.name} тип #{train.class == PassengerTrain ? 'пассажирский' : 'грузовой'}" }
  end
end
