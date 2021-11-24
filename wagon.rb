class Wagon
  include Company
  attr_reader :type
  def initialize(type)
    @type=type

  end
  def valid?
    validate!
    true
  rescue
    false
  end

  protected
  def validate!
    raise "Вы не ввели тип вагона" if @type.nil?
    raise "Неверный тип вагона" if @type != "cargo" && @type != "passenger"
  end
end
