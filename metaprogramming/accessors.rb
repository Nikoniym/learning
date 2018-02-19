module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym

      previous_history = instance_variable_get(:@previous_history)
      if previous_history.nil?
        instance_variable_set(:@previous_history, {})
        previous_history = {}
      end
      previous_history[name] = [] if previous_history[name].nil?
      instance_variable_set(:@previous_history, previous_history)

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|

        current_value = instance_variable_get(var_name)

        unless current_value.nil?
          previous_history[name] << current_value
          instance_variable_set(:@previous_history, previous_history)
        end

        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history".to_sym) do
        if !instance_variable_get(:@previous_history).nil?
          instance_variable_get(:@previous_history)[name]
        else
          nil
        end
      end
    end
  end

  def strong_attr_acessor(arg, type)
    var_name = "@#{arg}".to_sym
    variable = instance_variable_get(var_name)
    define_method(arg) { instance_variable_get(var_name) }
    define_method("#{arg}=".to_sym) do |value|
      if value.is_a? type
        instance_variable_set(var_name, value)
      else
        raise 'Type error!!!'
      end
    end
  end
end
