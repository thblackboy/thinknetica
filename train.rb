class Train
  #Вывод количества вагонов obj.wagon_count
  attr_reader :wagon_count, :type
  attr_accessor :speed
  
  def initialize(number, type , wagon_count)
    #Номер, тип (freight - грузовой, passenger - пассажирский, кол-во вагонов)
    @number = number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
  end

  def go
    #набирает скорость
    self.speed = 100
  end

  def stop
    #сбрасывает до нуля
    self.speed = 0
  end

  def add_wagon
    #добавление вагода при полной остановке
    if speed == 0
      @wagon_count += 1
    end
  end

  def del_wagon
    #удаление вагода при полной остановке
    if speed == 0
      @wagon_count -= 1
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
    if @station_index != 0
    @route.stations[@station_index - 1]
    else
      nil
    end
  end

  def next_station
    #Возврат следующей станции
    if @station_index != @route.stations.size - 1
      @route.stations[@station_index + 1]
    else
      nil
    end
  end

end