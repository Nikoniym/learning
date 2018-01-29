class Station
  attr_reader :name
  attr_accessor :train

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train    
    if @train   
      if @trains.select{ |train_station| train_station.name == @train.name }.size.zero? #проверка есть ли поезд с таким номером на станции
       @trains << @train
       puts "Поезд с № #{@train.name} прибыл станцию"
      else
        puts "Поезд с № #{@train.name} уже на станции"
      end
    else
      puts 'Установите, какой поезд должен прибыть'
    end
  end

  def list_trains
    if !@trains.empty?
      @trains.each { |train|  puts "Поезд № #{train.name} тип #{train.type}" }
    else
      puts 'На станции нет поездов'
    end
  end

  def list_trains_type
    if !@trains.empty?
      types = []
      @trains.each { |train| types << train.type } 

      types.uniq.each do |type|
        count = @trains.select{ |train| train.type == type }.size
        puts "Тип #{type}: #{count}"
      end
    else
      puts 'На станции нет поездов'
    end      
  end

  def send_train
    if !@trains.empty?  
      if @trains.select{ |train_station| train_station.name == @train.name }.size > 0    
        @trains.delete(@train)
        puts "Поезд с № #{@train.name} убыл со станции" 
      else
        puts 'Поезда с таким номером нет'
      end
    else
      puts 'На станции нет поездов'
    end
  end
end