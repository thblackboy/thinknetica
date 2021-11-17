class Station
	#Вывод названия станции и всех поездов на станции через obj.name и obj.trains
  attr_reader :trains,:name
  def initialize(name)
  	#Добавление названия при инициализации
    @name=name
    @trains=[]
  end

  def take_train(train)
  	#Прием поездов
  	train.stop  	
    @trains<<train
  end

  def send_train(train)
  	#Отправка поезда
  	if @trains.include?(train)
  	  train.go
  	  train.move_train
  	  @trains.delete(train)
  	end
  end

  def trains_by_type
  	#Вывод поездов на станции по типу: 0-грузовые, 1-пассажирские
  	gruz_train_count=0
  	pas_train_count=0
  	@trains.each do |train|
  		if train.type ==0
  			gruz_train_count+=1
  		else
  			pas_train_count+=1
  		end
  	end
  	puts "Gruzovie #{gruz_train_count}  Passagers #{pas_train_count}"
  end







