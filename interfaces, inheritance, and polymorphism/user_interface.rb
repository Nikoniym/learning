class UserInterface
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def info
    puts 'Введите 1 для создания станций'
    puts 'Введите 2 для создания поездов'
    puts 'Введите 3 для создания маршрута'
    puts 'Введите 4 для добавление удаления станций к маршруту'
    puts 'Введите 5 для назначения маршрута поезду'
    puts 'Введите 6 для изменения количества вагонов в поезде'
    puts 'Введите 7 для перемещать поезд по маршруту вперед и назад'
    puts 'Введите 8 для просмотра списка станций в маршруте'
    puts 'Введите 9 для просмотра списка поездов на станции'
    user_response
  end

  private

  def user_response
    case gets.chomp.to_i
      when 1 then create_stations
      when 2 then create_trains
      when 3 then create_route
      when 4 then change_route
      when 5 then set_route
      when 6 then change_cars
      when 7 then movement_rote
      when 8 then list_stations
      when 9 then list_trains
      else
        puts 'Ошибка ввода!!!'
        info
    end
  end

  def create_stations
    puts "Введите название станции или для возвращения обратно нажмите клавишу enter"
    loop  do
      name = gets.chomp
      break if name == ''
      @stations << Station.new(name)
    end
    info
  end

  def create_trains
    loop do
      puts "Введите номер поезда или для возвращения обратно нажмите клавишу enter"
      number = gets.chomp
      break if number == ''

      puts "Выберите тип поезда. Введите 1 если пассажирский. Введите 2 если грузовой"
      case type = gets.chomp.to_i
        when 1 then @trains << PassengerTrain.new(number)
        when 2 then @trains << CargoTrain.new(number)
        else puts 'Ошибка ввода!!!'
      end
    end
    info
  end


  def create_route
    if @stations.size >= 2
      loop do
        show_list(@stations)
        puts "Введите номер начальной станции в маршруте или для возвращения обратно нажмите клавишу enter"
        first_station = gets.chomp
        break if input_validation?(first_station, @stations)

        puts "Введите номер конечной станции в маршруте"
        last_station = gets.chomp
        if last_station.to_i != first_station.to_i || input_validation?(last_station, @stations)
          @routes << Route.new(@stations[first_station.to_i - 1], @stations[last_station.to_i - 1])
        else
          puts 'Ошибка ввода!!!'
        end
      end
    else
      puts 'Для установки маршрута недостаточно станций!!!'
    end
    info
  end

  def change_route
    if @stations.size > 2
      puts "Введите номер маршрута для изменеия промежуточных станции"
      show_list(@routes)
      route = @routes[gets.chomp.to_i - 1]

      puts 'Введите 1 - если хотите добавить станцию. Введите 2 - еcли удалить'
      action = gets.chomp.to_i

      loop do
        show_list(@stations)
        puts "Введите номер станции или для возвращения обратно нажмите клавишу enter"
        station = gets.chomp
        break if input_validation?(station, @stations)
        case action
          when 1 then route.add_station(@stations[station.to_i - 1])
          when 2 then route.delete_station(@stations[station.to_i - 1])
          else puts "Номе указан неверно!!!"
        end
      end
    else
      puts 'Для изменения маршрута недостаточно станций!!!'
    end
    info
  end

  def set_route
    if (@routes.size && @trains.size) > 0
      loop do
        show_list(@trains)
        puts "Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter"
        train = gets.chomp
        break if input_validation?(train, @trains)

        puts "Введите номер маршрута"
        show_list(@routes)
        @trains[train.to_i - 1].set_route(@routes[gets.chomp.to_i - 1])
      end
    else
      puts 'У вас нет маршрутов или поездов!!!'
    end
    info
  end

  def change_cars
    if  @trains.size > 0
      loop do
        show_list(@trains)
        puts "Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter"
        train = gets.chomp

        break if input_validation?(train, @trains)
        add_and_remove_cares(train)
      end
    else
      puts "Поездов нет!!!"
      create_trains
    end
    info
  end

  def add_and_remove_cares(train)
    puts 'Введите 1 - если хотите добавить вагоны. Введите 2 - еcли удалить'
    action = gets.chomp.to_i

    puts 'Введите количесво вагонов'
    case action
      when 1 then  gets.chomp.to_i.times { @trains[train.to_i - 1].add_car(@trains[train.to_i - 1].class == PassengerTrain ? PassengerCar.new : CargoCar.new) }
      when 2
        count = gets.chomp.to_i
        if @trains[train.to_i - 1].cars.size >= count
          puts 'Введите 1 - для удаления сначала состава. Введите 2 - для удаления с конца состава'
          action = gets.chomp.to_i
          count.times { @trains[train.to_i - 1].delete_car(action) }
        else
          puts "У поезда всего #{@trains[train.to_i - 1].cars.size} вагонов"
        end
      else puts 'Ошибка ввода!!!'
    end
  end

  def movement_rote
    if @trains.size > 0
      loop do
        show_list(@trains)

        puts "Введите номер необходимого поезда или для возвращения обратно нажмите клавишу enter"
        train = gets.chomp

        break if input_validation?(train, @trains)
        puts 'Введите 1 - Двежение на следующую станцию. Введите 2 - Движение на предыдущую станцию'
        action = gets.chomp.to_i
        case action
          when 1 then @trains[train.to_i - 1].go_next_station
          when 2 then @trains[train.to_i - 1].go_prev_station
          else puts 'Ошибка ввода!!!'
        end
      end
    else
      puts "Поездов нет!!!"
      create_trains
    end
    info
  end

  def list_stations
    if @routes.size > 0
      loop do
        show_list(@routes)
        puts "Введите номер маршрута для отображения списка станций или для возвращения обратно нажмите клавишу enter"
        route = gets.chomp
        break if input_validation?(route, @routes)
        @routes[route.to_i - 1].all_stations
      end
    else
      puts 'Нет маршрутов!!!'
      create_route
    end
    info
  end

  def list_trains
    if @stations.size > 0
      loop do
        show_list(@stations)
        puts "Введите номер станции для отображения находящихся на ней поездов или для возвращения обратно нажмите клавишу enter"
        station = gets.chomp
        break if input_validation?(station, @stations)
        @stations[station.to_i - 1].list_trains
      end
    else
      puts 'Нет станций!!!'
      create_stations
    end
    info
  end

  def show_list(list)
    list.each.with_index(1) { |list, index| puts "#{index} - #{list.name}" }
  end

  def input_validation?(input, array)
    input == '' || input.to_i > array.size || input.to_i < 1
  end
end
