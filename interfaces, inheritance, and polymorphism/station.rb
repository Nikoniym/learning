class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
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
    @trains.each { |train| puts "Поезд № #{train.name} тип #{train.type}" }
  end
end
