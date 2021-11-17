class Train
	#Вывод количества вагонов obj.vagon_count
	attr_reader :vagon_count, :type
	attr_accessor :speed
	def initialize(number,type,vagon_count)
		#Номер, тип (0-груз,1 пассажиры, кол-во вагонов при инициализации)
		@number=number
		@type=type
		@vagon_count=vagon_count
		@speed=0
	end

	def go
		#набирает скорость
		self.speed=100
	end

	def stop
		#сбрасывает до нуля
		self.speed=0
	end

	def add_vagon
		#добавление вагода при полной остановке
		if speed==0
			@vagon_count+=1
		end
	end

	def del_vagon
		#удаление вагода при полной остановке
		if speed==0
			@vagon_count-=1
		end
	end

	def add_route(route)
		#Добавление маршрута
		if @route.nil?
			@route=route
			@station_index=0
			@route.stations[@station_index].take_train(self)
			@move=1
		end
	end

	def move_train
		#Перемещение между станциями. Переменная @move показывает направление движения поезда
		if @move==1
			if @route.stations.size-1!=@station_index
				@station_index+=1				
			else
				@station_index-=1
				@move=0
			end
			@route.stations[@station_index].take_train(self)
		else
			if @station_index!=0
				@station_index-=1				
			else
				@station_index+=1
				@move=1
			end
			@route.stations[@station_index].take_train(self)
		end
	end

	def current_station
		#Возврат текущей станции
		@route.stations[@station_index].name
	end

	def prev_station
		#Возврат предыдущей станции
		if @move==1
			if @station_index!=0
				@route.stations[@station_index-1].name
			end
		else
			if @station_index!=@route.stations.size-1
				@route.stations[@station_index-+].name
			end
		end
	end

	def next_station
		#Возврат следующей станции
		if @move==0
			if @station_index!=0
				@route.stations[@station_index-1].name
			end
		else
			if @station_index!=@route.stations.size-1
				@route.stations[@station_index-+].name
			end
		end
	end
end