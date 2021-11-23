class Wagon
  include Company
  attr_reader :type
  def initialize(type)
    @type=type
    validate!
  end
  def valid?
    validate!
    true
  rescue
    false
  end
  def to_s
    "id: #{self.object_id} тип: #{@type}"
  end
  protected
  def validate!
    raise "Вы не ввели тип вагона" if @type.nil?
    raise "Неверный тип вагона" if @type != "cargo" && @type != "passenger"
  end
end
