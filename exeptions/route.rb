class Route
  include Validation
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    @name = "#{first_station.name} - #{last_station.name}"
  end

  def add_station(new_station)
    if !@stations.include?(new_station)
      @stations.insert(-2, new_station)
    else
      puts "Станция #{name} уже есть в списке"
    end
  end

  def delete_station(delete_station)
    @stations.delete(delete_station) if @stations[1..-2].include?(delete_station)
  end

  def all_stations
    @stations.each.with_index(1) { |station, index| puts "#{index}: #{station.name}" }
  end

  private

  def validate!
    raise 'Названия станций не могут быть одинаковыми!!!' if  @stations[0] == @stations[1]
    raise 'Передаваемый объект не является объектом класса Station' if @stations[0].class != Station || @stations[1].class != Station
    true
  end
end
