class Wagon
  include Company
  include Validation
  extend Accessors
  attr_reader :type
  def initialize(type)
    @type=type

  end

  protected
  def validate!
    self.class.validate :type, :presence
    raise "Неверный тип вагона" if @type != "cargo" && @type != "passenger"
  end
end
