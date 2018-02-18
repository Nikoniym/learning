module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym
      variable = instance_variable_get(var_name)
      define_method(name) { variable.nil? ? nil : variable[-1]}
      define_method("#{name}=".to_sym) do |value|
        variable.nil? ? variable = [value] : variable << value
        instance_variable_set(var_name, variable)
      end
      define_method("#{name}_history".to_sym) { variable }
    end
  end

  def strong_attr_acessor(arg, type)
    var_name = "@#{arg}".to_sym
    variable = instance_variable_get(var_name)
    define_method(arg) { instance_variable_get(var_name) }
    define_method("#{arg}=".to_sym) { |value| (value.is_a? type) ? instance_variable_set(var_name, value) : (puts 'Type error!!!') }
  end

end
