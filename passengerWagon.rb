class PassengerWagon < Wagon
  attr_reader :free_places, :taked_places
  def initialize(placeCount)
    super("passenger")
    @placeCount = placeCount
    @free_places = placeCount
    @taked_places = 0
    validate!
  end
  def takeplace
    raise "Все места уже заняты" if free_places <= 0
    @taked_places += 1
    @free_places -=1
    true
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def to_s
    "Тип: #{@type} Свободно: #{@free_places} мест Занято: #{@taked_places} мест"
  end
  protected
  def validate!
    super
    raise "Количество мест не может быть меньше или равно нулю" if @placeCount <= 0
  end
end
