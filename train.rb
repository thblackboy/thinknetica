 require_relative 'route.rb'
 class Train
  extend Accessors
  include Company
  include InstanceCounter
  include Validation
  #Вывод вагонов obj.wagons

  attr_reader :speed, :wagons, :route, :type
  validate :number, :presence
  validate :type, :presence
  validate :number, :format, /^([a-z]|\d){3}(-|)([a-z]|\d){2}$/i

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    #type cargo,passenger
    @number = number
    @wagons = []
    @speed = 0
    @type = type
    validate!
    @@trains[number] = self
    register_instance
  end


  def wagon_block_func(&block)
    @wagons.each do |wagon|
      yield(wagon)
    end
  end

  def go
    #набирает скорость
    @speed = init_speed
  end

  def stop
    #сбрасывает до нуля
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.type == @type
  end

  def del_wagon(wagon)
    #удаление вагода при полной остановке
    if @speed.zero?
      @wagons.delete(wagon) if @wagons.include?(wagon)
    end
  end

  def add_route(route)
    #Добавление маршрута
    if @route.nil?
      @route = route
      @station_index = 0
      @route.stations[@station_index].take_train(self)
    end
  end

  def move_train_up
    #Перемещение между станциями вперед.
    if @route.stations.size - 1 != @station_index
    	@route.stations[@station_index].send_train(self)
      @station_index += 1
      @route.stations[@station_index].take_train(self)
    end
  end

  def move_train_down
    #Перемещение между станциями назад.
    if @station_index!=0
    	@route.stations[@station_index].send_train(self)
      @station_index -= 1
      @route.stations[@station_index].take_train(self)
    end
  end

  def current_station
    #Возврат текущей станции
    @route.stations[@station_index]
  end

  def prev_station
    #Возврат предыдущей станции
    @route.stations[@station_index - 1] if @station_index != 0
  end

  def next_station
    #Возврат следующей станции
    @route.stations[@station_index + 1] if @station_index != @route.stations.size - 1
  end

  def to_s
    "Номер поезда: #{@number} тип: #{@type} маршрут: #{@route}"
  end

  protected
  strong_attr_accessor :route => Route, :type => String
  #Закрыл доступ к скорости поезда при движении
  def init_speed
    100
  end

  def validate!
    super
    raise "Неверный тип поезда" if @type != "cargo" && @type != "passenger"
  end

end
