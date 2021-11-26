module Validation
    def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, typ, param = nil)
      var_name = "@#{name}".to_sym
      case typ
      when :presence
        raise "#{var_name} пустая" if instance_variable_get(var_name).nil? || instance_variable_get(var_name).strip == ""
      when :format
        raise "#{var_name} не соответсвует требуемуму формату" if instance_variable_get(var_name) !~ param
      when :type
        raise "#{var_name} не соответсвует требуемуму типу" if instance_variable_get(var_name).class != param
      else
        raise "Некорректная проверка"
      end
    end
  end

  module InstanceMethods
    def validate!
    end

    def valid?
      validate!
      true
    rescue
      false
    end


  end



end
