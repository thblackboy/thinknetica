class Route
  include InstanceCounter
  #Вывод всех станций по порядку, с помощью obj.stations
  attr_reader :stations
  def initialize(start_station, end_station)
    #Начальная и конечная станция при инизиализации
    @stations = [start_station, end_station]
    validate!
    register_instance
  end
  def valid?
    validate!
    true
  rescue
    false
  end

  def add_station(station)
    #Добавить промежуточную станцию в список
    unless stations.include?(station)
      stations.insert(-2, station)
    end
  end

  def del_station(station)
    #Удалить промежуточную станцию из списка
    if @stations.include?(station)
      unless station == @stations.first && station == @stations.last
        stations.delete(station)
      end
    end
  end

  def to_s
    "Начальная станция: #{stations.first} Конечная станция: #{stations.last}"
  end
  protected
  def validate!
    raise "Неверный тип введенных аргументов" if @stations.first.class != Station || @stations.last.class != Station
    raise "Начальная и конечная станция совпадают" if @stations.first == @stations.last
  end
end
