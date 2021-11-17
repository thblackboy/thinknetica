class Route
  #Вывод всех станций по порядку, с помощью obj.stations
  attr_reader :stations
  def initialize(start_station, end_station)
    #Начальная и конечная станция при инизиализации
    @stations = [start_station, end_station]
  end

  def add_station(station)
    #Добавить промежуточную станцию в список
    unless stations.include?(station)
      stations.insert(-2, station)
    end
  end

  def del_station(station)
    #Удалить промежуточную станцию из списка
    unless station == stations.first && station == stations.last
      stations.delete(station)
      #Убираем nil обьекты из массива stations
      stations.compact!
    end
  end
end