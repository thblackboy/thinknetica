class Wagon
  include Company
  attr_reader :type
  def initialize(type)
    @type=type
  end
  def to_s
    "id: #{self.object_id} тип: #{@type}"
  end
end
