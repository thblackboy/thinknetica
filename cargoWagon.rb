class CargoWagon < Wagon
  attr_reader :free_volume, :used_volume
  def initialize(volume)
    super("cargo")
    @free_volume = volume
    @used_volume = 0
    validate!
  end

  def take_volume (volume)
    raise "Недостаточно места в вагоне" if volume > @free_volume
    @free_volume -= volume
    @used_volume += volume
    true
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def to_s
    "Тип: #{@type} Доступный объем: #{@free_volume} Занято: #{@used_volume}"
  end

  protected
  def validate!
    super
    raise "Обьем должен быть больше нуля" if @free_volume <= 0
  end

end
