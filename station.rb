class Station
  include InstanceCounter
  #Вывод названия станции и всех поездов на станции через obj.name и obj.trains
  attr_reader :trains, :name
  @@stations = []
  def self.all
    @@stations
  end

  NAME_FORMAT = /^[А-Я]{1}.+$/


  def initialize(name)
    #Добавление названия при инициализации
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
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
    #Вывод массива поездов по типу (cargo - грузовой, passenger - пассажирский)
    @trains.select { |train| train.type == type }
  end

  def trains_by_type_count(type)
    #Вывод кол-ва поездов по типу (cargo - грузовой, passenger - пассажирский)
    trains_by_type(type).size
  end

  def to_s
    "#{@name}"
  end

  protected
  def validate!
    raise "Название не соответвует формату" if @name !~ NAME_FORMAT
    raise "Длина названия должна быть более 5 символов" if @name.length < 5
  end

end
