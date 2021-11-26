module Accessors
  def attr_accessor_with_history (*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method (name) {instance_variable_get (var_name)}

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        if instance_variable_get("@#{name}_history".to_sym).nil?
          instance_variable_set("@#{name}_history".to_sym, [])
          instance_variable_get("@#{name}_history".to_sym).push(value)
        else
          instance_variable_get("@#{name}_history".to_sym).push(value)
        end
      end

      define_method("#{name}_history".to_sym) {instance_variable_get("@#{name}_history".to_sym)}

    end
  end

  def strong_attr_accessor (hashes={})
    hashes.each do |name, classname|
      var_name = "@#{name}".to_sym
      define_method (name) {instance_variable_get (var_name)}

      define_method("#{name}=".to_sym) do |value|
        begin
        if value.class == classname
          instance_variable_set(var_name, value)
        else
          raise "Введенные данные не соответсвуют по типу"
        end
        rescue RuntimeError => e
          puts "#{e.message}"
        end
      end

    end
  end

end

