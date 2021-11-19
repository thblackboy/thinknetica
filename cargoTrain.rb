class CargoTrain < Train

  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.class == CargoWagon
  end

end
