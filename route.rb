class Route
	#Вывод всех станций по порядку, с помощью obj.stations
	attr_reader :stations, :end_station, :start_station
  def initialize(start_station,end_station)
  	#Начальная и конечная станция при инизиализации
  	@start_station=start_station
  	@end_station=end_station
  	@stations=[start_station,end_station]
  end

  def add_station(station)
  	#Добавить промежуточную станцию в список
  	unless stations.include?(station)
  		stations.last=station
  		stations<<end_station
  	end
  end

  def del_station(station)
  	#Удалить промежуточную станцию из списка
  	unless station==start_station && station==end_station
  		stations.delete(station)
  		stations.compact!
  	end
  end
end