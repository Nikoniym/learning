class Route
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station  
    @name = "#{first_station} - #{last_station}"
    @stations = [@first_station, @last_station]
  end

  def add_station(name)
    if !way_stations.nil?
      @way_stations << name
     else
      @way_stations = [name]
    end
    puts "Станция #{name} добавлена"
    @stations = [@first_station] + @way_stations + [@last_station]
  end

  def delete_station(name)
    if !way_stations.nil? 
      if way_stations.include?(name)
        @way_stations.delete(name) 
        puts "Станция #{name} удалена из маршрута"
        @stations = [@first_station] + @way_stations + [@last_station]
      else
        puts "Станции #{name}, нет в списке станций"
      end
    else
      puts 'Промежуточных санций нет'
    end
  end

  def all_stations
    puts @first_station
    @way_stations.each { |station| puts station } if !way_stations.nil?
    puts @last_station
    @stations = [@first_station] + @way_stations + [@last_station]
  end
end