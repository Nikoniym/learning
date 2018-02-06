class Station
  include InstanceCounter

  attr_reader :name
  attr_reader :instances



  def initialize(name)
    @name = name
    @trains = []
    register_instance
  end

  def self.all
    ObjectSpace.each_object(self).to_a
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
