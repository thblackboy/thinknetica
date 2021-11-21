require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'passengerTrain.rb'
require_relative 'cargoTrain.rb'
require_relative 'passengerWagon.rb'
require_relative 'cargoWagon.rb'
class RailRoad

  def initialize
    @routes = []
    @stations = []
    @wagons = []
    @trains = []

  end

  def menu
    puts "1 - Создать станцию, поезд, маршрут или вагон"
    puts "2 - Произвести операцию с созданными объектами"
    puts "3 - Вывести данные об объектах"
    puts "4 - Выход"
    print "Ваш выбор: "
    choise = gets.chomp.to_i
    case choise
    when 1
      create
    when 2
      operations_with_obj
    when 3
      show_datas
    else
      nil
    end
  end

  private

  def create_station
    print "Введите название станции: "
    name = gets.chomp
    @stations << Station.new(name)
  end

  def station_list(stations)
    puts "Список станций: "
    index = 0
    stations.each do |station|
      puts "#{index} - #{station}"
      index += 1
    end
  end

  def route_list
    puts "Список созданных маршрутов: "
    index = 0
    @routes.each do |route|
      puts "#{index} - #{route}"
      index += 1
    end
  end

  def train_list
    puts "Список поездов: "
    index = 0
    @trains.each do |train|
      puts "#{index} - #{train}"
      index += 1
    end
  end

  def wagon_list(wagons)
    puts "Список вагонов: "
    index = 0
    wagons.each do |wagon|
      puts "#{index} - #{wagon}"
      index += 1
    end
  end

  def create_route
    create_route! if @stations.size >= 2
  end

  def create_route!
    station_list(@stations)
    print "Введите индекс начальной станции: "
    start_station_index = gets.chomp.to_i
    start_station = @stations[start_station_index]
    unless start_station.nil?
      print "Введите индекс конечной станции: "
      end_station_index = gets.chomp.to_i
      end_station = @stations[end_station_index]
      unless end_station.nil? && end_station == start_station
        @routes << Route.new(start_station, end_station)
      else
        nil
      end
    end
  end

  def create_train
    print "Введите номер поезда: "
    number = gets.chomp
    puts "Выберите тип поезда:"
    puts "1 - Грузовой"
    puts "2 - Пассажирский"
    type = gets.chomp.to_i
    case type
    when 1
      @trains << CargoTrain.new(number)
    when 2
      @trains << PassengerTrain.new(number)
    else
      puts "Несуществующий вариант ответа"
    end
  end


  def create_wagon
    puts "Выберите тип вагона:"
    puts "1 - Грузовой"
    puts "2 - Пассажирский"
    print "Ваш выбор: "
    case gets.chomp.to_i
    when 1
      @wagons << CargoWagon.new
    when 2
      @wagons << PassengerWagon.new
    else
      puts "Несуществующий вариант ответа"
    end
  end

  def select_object_type
    puts "1 - Станции"
    puts "2 - Маршруты"
    puts "3 - Поезда"
    puts "4 - Вагоны"
    print "Ваш выбор: "
    gets.chomp.to_i
  end

  def create
    case select_object_type
    when 1
      create_station
    when 2
      create_route
    when 3
      create_train
    when 4
      create_wagon
    else
      puts "Несуществующий вариант ответа"
    end
  end

  def add_station_to_route
    add_station_to_route! if @routes.any?
  end

  def add_station_to_route!
    route_list
    print "Введите индекс маршрута, который желаете изменить: "
    route_index = gets.chomp.to_i
    unless @routes[route_index].nil?
      station_list(@stations)
      print "Введите индекс станции, которую желаете добавить: "
      station_index = gets.chomp.to_i
      unless @stations[station_index].nil?
        @routes[route_index].add_station(@stations[station_index])
      else
        puts "Введенной станции не существует"
      end
    else
      puts "Введенного маршрута не существует"
    end
  end

  def del_station_to_route
    del_station_to_route! if @routes.any?
  end

  def del_station_to_route!
    route_list
    print "Введите индекс маршрута, который желаете изменить: "
    route_index = gets.chomp.to_i
    unless @routes[route_index].nil?
      station_list(@routes[route_index].stations)
      print "Введите индекс станции, которую желаете удалить: "
      station_index = gets.chomp.to_i
      unless @routes[route_index].stations[station_index].nil?
        @routes[route_index].del_station(@routes[route_index].stations[station_index])
      else
        puts "Введенной станции не существует"
      end
    else
      puts "Введенного маршрута не существует"
    end
  end

  def add_route_to_train
    add_route_to_train! if @trains.any?
  end

  def add_route_to_train!
    train_list
    print "Введите индекс поезда, которому хотите назначить маршрут: "
    train_index = gets.chomp.to_i
    unless @trains[train_index].nil?
      route_list
      print "Введите индекс маршрута, который хотите назначить: "
      route_index = gets.chomp.to_i
      unless @routes[route_index].nil?
        @trains[train_index].add_route(@routes[route_index])
        else
        puts "Введенного маршрута не существует"
      end
    else
      puts "Введенного поезда не существует"
    end
  end

  def add_wagon_to_train
    add_wagon_to_train! if @trains.any? && @wagons.any?
  end

  def add_wagon_to_train!
    train_list
    print "Введите индекс поезда, которому хотите добавить вагон: "
    train_index = gets.chomp.to_i
    unless @trains[train_index].nil?
      wagon_list(@wagons)
      print "Введите индекс вагона, который хотите прицепить: "
      wagon_index = gets.chomp.to_i
      unless @wagons[wagon_index].nil?
        @trains[train_index].add_wagon(@wagons[wagon_index])
        else
        puts "Введенного вагона не существует"
      end
    else
      puts "Введенного поезда не существует"
    end
  end

  def del_wagon_to_train
    del_wagon_to_train! if @trains.any?
  end

  def del_wagon_to_train!
    train_list
    print "Введите индекс поезда, которому хотите отцепить вагон: "
    train_index = gets.chomp.to_i
    unless @trains[train_index].nil? && @trains[train_index].wagons.size == 0
      wagon_list(@trains[train_index].wagons)
      print "Введите индекс вагона, который хотите отцепить: "
      wagon_index = gets.chomp.to_i
      unless @trains[train_index].wagons[wagon_index].nil?
        @trains[train_index].del_wagon(@trains[train_index].wagons[wagon_index])
        else
        puts "Введенного вагона не существует"
      end
    else
      puts "Введенного поезда не существует"
    end
  end

  def move_train
    move_train! if @trains.any?
  end

  def move_train!
    train_list
    print "Введите индекс поезда, который хотите переместить: "
    train_index = gets.chomp.to_i
    unless @trains[train_index].route.nil?
      puts "1 - Движение вперед, 2 - Движение назад"
      print "Ваш выбор: "
      case gets.chomp.to_i
      when 1
        puts "Успешно" unless @trains[train_index].move_train_up.nil?
      when 2
        puts "Успешно" unless @trains[train_index].move_train_down.nil?
      else
        puts "Введенного вами варианта не существует"
      end
    else
      puts "Выбран поезд без маршрута"
    end
  end

  def show_stations
    station_list(@stations) if @stations.any?
  end

  def show_trains_on_station
    @stations.each do |station|
      puts "Станция: #{station}"
      puts station.trains
      puts ""
    end
  end




  def operations_with_obj
    puts "1 - Добавить станцию в маршруте"
    puts "2 - Удалить станцию в маршруте"
    puts "3 - Назначение маршрута поезду"
    puts "4 - Добавление вагона к поезду"
    puts "5 - Отцепление вагона от поезда"
    puts "6 - Перемещение поезда по маршруту назад и вперед"
    print "Ваш выбор:"
    case gets.chomp.to_i
    when 1
      add_station_to_route
    when 2
      del_station_to_route
    when 3
      add_route_to_train
    when 4
      add_wagon_to_train
    when 5
      del_wagon_to_train
    when 6
      move_train
    else
      nil
    end
  end

  def show_datas
    puts "1 - Список станций"
    puts "2 - Список станций и поездов на них"
    print "Ваш выбор: "
    case gets.chomp.to_i
    when 1
      show_stations
    when 2
      show_trains_on_station
    else
      nil
    end
  end
end
