class Station
  #Вывод названия станции и всех поездов на станции через obj.name и obj.trains
  attr_reader :trains, :name
  def initialize(name)
    #Добавление названия при инициализации
    @name = name
    @trains = []
  end

  def take_train(train)
    #Прием поездов
    train.stop  	
    @trains << train
  end

  def send_train(train)
    #Отправка поезда
    @trains.delete(train)
  end

  def trains_by_type(type)
    #Вывод массива поездов по типу (freight - грузовой, passenger - пассажирский)
    arr_trains=trains.map { |train| train if train.type == type  }
    arr_trains.compact!
  end

  def trains_by_type_count(type)
    #Вывод кол-ва поездов по типу (freight - грузовой, passenger - пассажирский)
    trains_by_type(type).size
  end

end