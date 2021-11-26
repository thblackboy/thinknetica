class CargoWagon < Wagon

  def initialize(volume)
    super("cargo")
    @free_volume = volume
    @used_volume = 0
    validate!
  end

  def total_volume
    @free_volume + @used_volume
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
  strong_attr_accessor :free_volume => Fixnum, :used_volume => Fixnum

  def validate!
    super
    validate :free_volume, :type, Fixnum
    raise "Обьем должен быть больше нуля" if @free_volume <= 0
  end

end
