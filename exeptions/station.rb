class Station
  include Validation
  include InstanceCounter
  attr_reader :name

  @@stations = []

  def initialize(name)
    @name = name
    validate!
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

  private

  def validate!
    raise "Станция #{@name} уже существует" if  @@stations.select{ |station| station.name == @name}.size > 0
    true
  end
end
