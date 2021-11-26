class Wagon
  include Company
  include Validation
  extend Accessors
  attr_reader :type
  validate :type, :presence
  def initialize(type)
    @type=type

  end

  protected
  def validate!
    super
    raise "Неверный тип вагона" if @type != "cargo" && @type != "passenger"
  end
end
