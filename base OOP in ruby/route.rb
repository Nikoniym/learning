class Route
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @first_station = Station.new(first_station)
    @last_station = Station.new(last_station)
    @way_stations = [] 
    @name = "#{first_station} - #{last_station}"
    @stations = [@first_station, @last_station]
  end
  
  def add_station(name)  
    if @way_stations.select{ |station| station.name == name}.size.zero?     
      @way_stations << Station.new(name)      
    
      puts "Станция #{name} добавлена"
      @stations = [@first_station] + @way_stations + [@last_station]
    else
      puts "Станция #{name} уже есть в списке"
    end
  end

  def delete_station(name)    
    if @way_stations.select{ |station| station.name == name}.size > 0

      @way_stations.each_with_index do |station, index| 
        if station.name == name
          @way_stations.delete_at(index) 
          puts "Станция #{name} удалена из маршрута"

          @stations = [@first_station] + @way_stations + [@last_station]        
        end
      end
    else
      puts "Станции #{name}, нет в списке промежуточных станций"
    end   
  end

  def all_stations
    puts @first_station.name
    @way_stations.each { |station| puts station.name } if !@way_stations.nil?
    puts @last_station

    @stations = [@first_station] + @way_stations + [@last_station]
  end
end