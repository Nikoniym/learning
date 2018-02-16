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

  def validate!
    unless @@stations.select { |station| station.name == @name }.empty?
      raise "Станция #{@name} уже существует"
    end
    raise 'Поле название станции не может быть пустым' if @name.empty?
    true
  end
end
