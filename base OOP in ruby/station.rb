class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)     
    if @trains.select{ |train_station| train_station.name == train.name }.size.zero? #проверка есть ли поезд с таким номером на станции
      @trains << train
      puts "Поезд с № #{train.name} прибыл станцию"
    else
      puts "Поезд с № #{train.name} уже на станции"
    end   
  end

  def list_trains
    if !@trains.empty?
      @trains.each { |train|  puts "Поезд № #{train.name} тип #{train.type}" }
    else
      puts 'На станции нет поездов'
    end
  end

  def list_trains_type(type)
    if !@trains.empty?      
      @trains.each { |train| puts train if type == train.type }      
    else
      puts 'На станции нет поездов'
    end      
  end

  def send_train(train)
    if !@trains.empty?  
      if @trains.select{ |train_station| train_station == train }.size > 0    
        @trains.delete(train)         
      else
        puts 'Поезда с таким номером нет'
      end
    else
      puts 'На станции нет поездов'
    end
  end
end