class Station
  include Validation
  include InstanceCounter
  attr_reader :name

  validate :name, :presence

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    validate_unique!
    @trains = []
    register_instance
    @@stations << self
  end

  def each_trains
    @trains.each { |train| yield(train) } if block_given?
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
    @trains.each do |train|
      puts "Поезд № #{train.name}"
      puts "Тип #{train.is_a? PassengerTrain ? 'пассажирский' : 'грузовой'}"
    end
  end

  private

  def validate_unique!
    unless @@stations.select { |station| station.name == @name }.empty?
      raise "Станция #{@name} уже существует"
    end
  end
end
