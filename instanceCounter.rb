module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0
    def instances
      @@instances
    end
    def addinstance
      @@instances +=1
    end
  end
  module InstanceMethods
    protected
    def register_instance
      self.class.addinstance
    end
  end
end
