class Station
  include InstanceCounter
  include Validation
  #Вывод названия станции и всех поездов на станции через obj.name и obj.trains

  attr_reader :trains, :name
  validate :name, :presence
  validate :name, :format, /^[А-Я]{1}.+$/
  @@stations = []

  def self.all
    @@stations
  end


  def initialize(name)
    #Добавление названия при инициализации
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end


  def train_block_func(&block)
    @trains.each do |train|
      yield(train)
    end
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


end
