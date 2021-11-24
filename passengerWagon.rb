class PassengerWagon < Wagon
  attr_reader :free_places, :taked_places
  def initialize(place_count)
    super("passenger")
    @free_places = place_count
    @taked_places = 0
    validate!
  end

  def take_place
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
    raise "Количество мест не может быть меньше или равно нулю" if @free_places <= 0
  end

end
