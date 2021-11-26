module Validation
    def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :h

    def validate(name, type, param = 0)
      self.h={} if self.h.nil?
      if self.h[type].nil?
        self.h[type] = []
        self.h[type] << [name, param]
      else
        self.h[type] << [name, param]
      end
    end

  end

  module InstanceMethods
    def validate!
      self.class.h.each do |key, values|
        values.each do |value|
          eval("validate_#{key}('#{value[0]}', '#{value[1]}')")
        end
      end
    end

    def validate_presence(name, param)
      raise "#{name} пустая" if instance_variable_get("@#{name}".to_sym).nil? || instance_variable_get("@#{name}".to_sym).strip == ""
    end

    def validate_format(name, param)
      raise "#{name} не соответсвует требуемуму формату" if instance_variable_get("@#{name}".to_sym) !~ Regexp.new(param)
    end

    def validate_type(name, param)
      raise "#{name} не соответсвует требуемуму типу" if instance_variable_get("@#{name}".to_sym).class != param
    end


    def valid?
      validate!
      true
    rescue
      false
    end


  end

end



