class UserInterface
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def info
    puts ['Введите 1 для создания станций',
          'Введите 2 для создания поездов',
          'Введите 3 для создания маршрута',
          'Введите 4 для изменения промежуточных станций в маршруте',
          'Введите 5 для назначения маршрута поезду',
          'Введите 6 для изменения количества вагонов в поезде',
          'Введите 7 для перемещения поезд по маршруту вперед и назад',
          'Введите 8 для просмотра списка станций в маршруте',
          'Введите 9 для просмотра списка поездов на станции',
          'Введите 10 для просмотра списка вагонов у поезда',
          'Введите 11 для загрузки ваногов']
    user_response
  end

  private

  def user_response
    input = gets.chomp.to_i
    methods_arr
    if @methods_arr[input].nil? && input.zero?
      puts 'Ошибка ввода!!!'
      info
    else
      send methods_arr[input]
    end
  end

  def methods_arr
    @methods_arr = { 1 => :create_stations, 2 => :create_trains,
                     3 => :create_route,    4 => :change_route,
                     5 => :seting_route,    6 => :change_cars,
                     7 => :movement_rote,   8 => :list_stations,
                     9 => :list_trains,     10 => :list_cars,
                     11 => :loading_trains }
  end

  def create_stations
    puts 'Введите название станции или для возвращения обратно нажмите клавишу enter'
    loop do
      name = gets.chomp
      break if name == ''
      validate_station(name)
    end
    info
  end

  def validate_station(name)
    @stations << Station.new(name)
  rescue RuntimeError => e
    puts e.message
  end

  def create_trains
    loop do
      begin
        puts 'Введите номер поезда или для возвращения обратно нажмите клавишу enter'
        number = gets.chomp
        break if number == ''
        type_train(number)
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end
    info
  end

  def type_train(number)
    puts 'Выберите тип поезда. Введите 1 если пассажирский. Введите 2 если грузовой'
    type = gets.chomp.to_i
    case type
    when 1 then @trains << PassengerTrain.new(number)
    when 2 then @trains << CargoTrain.new(number)
    else puts 'Ошибка ввода!!!'
    end
  end

  def create_route
    if @stations.size >= 2
      multi_route
    else
      puts 'Для установки маршрута недостаточно станций!!!'
    end
    info
  end

  def multi_route
    loop do
      show_list(@stations)
      puts ['Введите номер начальной станции в маршруте',
            'или для возвращения обратно нажмите клавишу enter']
      first_station = gets.chomp
      break if input_validation?(first_station, @stations)
      route_validation(first_station)
    end
  end

  def route_validation(first_station)
    puts 'Введите номер конечной станции в маршруте'
    last_station = gets.chomp
    if !input_validation?(last_station, @stations)
      extend_route_validation(first_station, last_station)
    else
      puts 'Ошибка ввода!!!'
    end
  end

  def extend_route_validation(first_station, last_station)
    @routes << Route.new(@stations[first_station.to_i - 1], @stations[last_station.to_i - 1])
  rescue RuntimeError => e
    puts e.message
  end

  def change_route
    if @stations.size > 2
      puts 'Введите номер маршрута для изменеия промежуточных станции'
      show_list(@routes)
      route = @routes[gets.chomp.to_i - 1]

      multi_add_station(route)
    else
      puts 'Для изменения маршрута недостаточно станций!!!'
    end
    info
  end

  def multi_add_station(route)
    puts 'Введите 1 - если хотите добавить станцию. Введите 2 - еcли удалить'
    action = gets.chomp.to_i
    loop do
      show_list(@stations)
      puts 'Введите номер станции или для возвращения обратно нажмите клавишу enter'
      station = gets.chomp
      break if input_validation?(station, @stations)
      check_add_or_remove_station(route, action, station)
    end
  end

  def check_add_or_remove_station(route, action, station)
    case action
    when 1 then route.add_station(@stations[station.to_i - 1])
    when 2 then route.delete_station(@stations[station.to_i - 1])
    else puts 'Номе указан неверно!!!'
    end
  end

  def seting_route
    if !@routes.size.zero? && !@trains.size.zero?
      multi_train_for_seting_route
    else
      puts 'У вас нет маршрутов или поездов!!!'
    end
    info
  end

  def multi_train_for_seting_route
    loop do
      show_list(@trains)
      input_number
      break if input_validation?(@train, @trains)
      extend_seting_route(@train)
      show_list(@routes)
    end
  end

  def extend_seting_route(train)
    puts 'Введите номер маршрута'
    @trains[train.to_i - 1].seting_route(@routes[gets.chomp.to_i - 1])
  end

  def input_number
    puts 'Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter'
    @train = gets.chomp
  end

  def change_cars
    if !@trains.empty?
      loop do
        show_list(@trains)
        puts 'Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter'
        train = gets.chomp
        break if input_validation?(train, @trains)
        add_and_remove_cars(@trains[train.to_i - 1])
      end
    else
      puts 'Поездов нет!!!'
    end
    info
  end

  def add_and_remove_cars(train)
    puts 'Введите 1 - если хотите добавить вагон. Введите 2 - еcли удалить'
    action = gets.chomp.to_i
    case action
    when 1 then add_car(train)
    when 2 then remove_car(train)
    else puts 'Ошибка ввода!!!'
    end
  end

  def add_car(train)
    if train.class == PassengerTrain
      puts 'Введите количесво мест в вагоне'
      place_count = gets.chomp.to_i
      train.add_car PassengerCar.new(place_count)
    else
      puts 'Введите объем вагона'
      volume = gets.chomp.to_i
      train.add_car CargoCar.new(volume)
    end
  end

  def remove_car(train)
    if !train.cars.empty?
      puts 'Введите номер вагона чтобы его отцепить'
      count_cars = train.cars.count
      1.upto(count_cars) { |index| puts index }
      input_number_car(train)
    else
      puts 'У поезда нет вагонов!!!'
    end
  end

  def input_number_car(train)
    car = gets.chomp.to_i
    train.delete_car(train.cars[car - 1]) if car > 0 && car <= train.cars.size
  end

  def list_cars
    if !@trains.empty?
      multi_car
    else
      puts 'Поездов нет!!!'
    end
    info
  end

  def multi_car
    loop do
      show_list(@trains)
      puts 'Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter'
      train = gets.chomp
      break if input_validation?(train, @trains)
      train = @trains[train.to_i - 1]
      check_type(train)
    end
  end

  def check_type(train)
    if train.class == PassengerTrain
      train.each_cars do |car, index|
        puts ["№ #{index} - пассажирский", "Cвободных мест - #{car.free_place_count}",
              "Занятых мест - #{car.take_place_count}"]
      end
    else
      train.each_cars do |car, index|
        puts ["#{index} - грузовой", "свободный объем - #{car.free_volume}",
              "занятый объем - #{car.occupied_volume}"]
      end
    end
  end

  def loading_trains
    if !@trains.empty?
      multi_train_for_loading
    else
      puts 'Поездов нет!!!'
    end
    info
  end

  def multi_train_for_loading
    loop do
      show_list(@trains)
      puts 'Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter'
      train = gets.chomp
      break if input_validation?(train, @trains)
      loading_cars(@trains[train.to_i - 1])
    end
  end

  def loading_cars(train)
    if !train.cars.empty?
      multi_car_for_loading(train)
    else
      puts 'Поездов нет!!!'
    end
    info
  end

  def multi_car_for_loading(train)
    loop do
      show_list_car(train)
      puts 'Введите номер необходимого вагона или для возвращения обратно нажмите клавишу enter'
      car = gets.chomp
      break if input_validation?(car, train.cars)
      car = train.cars[car.to_i - 1]
      change_free_place(car)
    end
  end

  def show_list_car(train)
    train.cars.each.with_index(1) do |car, index|
      puts "№ #{index}"
      puts "Свободно #{car.class == PassengerCar ? car.free_place_count : car.free_volume}"
    end
  end

  def change_free_place(car)
    if car.class == PassengerCar
      car.take_place
      puts "В вагоне занято #{car.take_place_count} мест"
    else
      puts "Объем свободного места вагона: #{car.free_volume}. На сколько загрузить объем"
      volume = gets.chomp.to_i
      car.add_volume(volume)
      puts "В вагоне занято #{car.occupied_volume}"
    end
  end

  def movement_rote
    if !@trains.empty?
      multi_train_for_movement
    else
      puts 'Поездов нет!!!'
    end
    info
  end

  def multi_train_for_movement
    loop do
      show_list(@trains)
      puts 'Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter'
      train = gets.chomp
      break if input_validation?(train, @trains)
      puts 'Введите 1 - Двежение на следующую станцию. Введите 2 - Движение на предыдущую станцию'
      check_movement(train)
    end
  end

  def check_movement(train)
    action = gets.chomp.to_i
    case action
    when 1 then @trains[train.to_i - 1].go_next_station
    when 2 then @trains[train.to_i - 1].go_prev_station
    else puts 'Ошибка ввода!!!'
    end
  end

  def list_stations
    if !@routes.empty?
      multi_station_for_list
    else
      puts 'Нет маршрутов!!!'
      create_route
    end
    info
  end

  def multi_station_for_list
    loop do
      show_list(@routes)
      puts ['Введите номер маршрута для отображения списка станций',
            'или для возвращения обратно нажмите клавишу enter']
      route = gets.chomp
      break if input_validation?(route, @routes)
      @routes[route.to_i - 1].all_stations
    end
  end

  def list_trains
    if !@stations.empty?
      multi_train_for_list
    else
      puts 'Нет станций!!!'
      create_stations
    end
    info
  end

  def multi_train_for_list
    loop do
      show_list(@stations)
      puts ['Введите номер станции для отображения находящихся на ней поездов',
            'или для возвращения обратно нажмите клавишу enter']
      station = gets.chomp
      break if input_validation?(station, @stations)
      @stations[station.to_i - 1].each_trains { |train| puts_train(train) }
    end
  end

  def puts_train(train)
    type = 'Пассажирский' if train.class == PassengerTrain
    type = 'Грузовой' if train.class == CargoTrain
    puts ["№ #{train.number}",
          type,
          "Количествово вагонов #{train.cars.count}"]
  end

  def show_list(list)
    list.each.with_index(1) do |list_in, index|
      puts "#{index} - #{list_in.class.superclass == Train ? list_in.number : list_in.name}"
    end
  end

  def input_validation?(input, array)
    input == '' || input.to_i > array.size || input.to_i < 1
  end
end
