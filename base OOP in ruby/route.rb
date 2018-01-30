class Route
  attr_reader :stations, :name

  def initialize(first_station, last_station)    
    @name = "#{first_station.name} - #{last_station.name}"
    @stations = [first_station, last_station]
  end
  
  def add_station(new_station)  
    if !@stations.include?(new_station)     
      @stations.insert(-2, new_station)      
    else
      puts "Станция #{name} уже есть в списке"
    end
  end

  def delete_station(delete_station)    
    if @stations[1..-2].include?(delete_station)
      @stations.delete(delete_station)
    else
      puts "Станции #{name}, нет в списке промежуточных станций"
    end   
  end

  def all_station
    puts @stations.join(' - ')
  end 
end