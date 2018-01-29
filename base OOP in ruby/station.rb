class Station
  attr_reader :name

  def initialize(name)
    self.name = name
  end

  def add_train(number, type)
    if @trains.nil? 
      @trains = [{number: number, type: type}] 
    else
      if @trains.select{ |train| train[:number] == number }.size == 0 #проверка на ошибку в воде номера поезда
       @trains << {number: number, type: type}
      else
        puts "Поезд с № #{number} уже на станции"
      end
    end
  end

  def list_trains
    if !@trains.nil?
      @trains.each { |train|  puts "Поезд № #{train[:number]} тип #{train[:type]}" }
    else
      puts 'На станции нет поездов'
    end
  end

  def list_trains_type
    if !@trains.nil?
      types = []
      @trains.each { |train| types << train[:type] } 

      types.uniq.each do |type|
        count = @trains.select{ |train| train[:type] == type }.size
        puts "Тип #{type}: #{count}"
      end
    else
      puts 'На станции нет поездов'
    end      
  end

  def send_train(number)
    if !@trains.nil?  
      if @trains.select{ |train| train[:number] == number }.size > 0    
        @trains.each_with_index { |train, index| @trains.delete_at(index) if train[:number] == number } 
      else
        puts 'Поезда с таким номером нет'
      end
    else
      puts 'На станции нет поездов'
    end
  end
end