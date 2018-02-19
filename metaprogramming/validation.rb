module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :variables

    def validate(name, *args)
      @variables ||= []
      create_hash_checks(args)
      @variables << [name, @checks] unless @variables.include?([name, @checks])
    end

    private

    def create_hash_checks(args)
      @checks = {}
      args.each do |arg|
        if arg == :presence
          @checks[arg] = nil
        else
          @checks[arg] = args[args.index(arg) + 1] if arg.is_a? Symbol
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.superclass.variables.each do |variable|
        value = instance_variable_get("@#{variable[0]}".to_sym)
        variable[1].each { |key, arg| send "validate_#{key}", variable[0], value, arg}
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def validate_presence(name, *args)
      raise "Значение  переменой '#{name}' не может быть пустым" if args[0].nil? || args[0] == ''
    end

    def validate_format(name, value, regular)
      if regular.is_a? Regexp
        raise 'Допустимый формат: XXX-XX или ХХХХХ' if value !~ regular
      else
        raise "Формат для переменной '#{name}'указан не верно!!!"
      end
    end

    def validate_type(name, value, type)
      raise "Тип переменной '#{name}' должен быть #{type}!!!" unless value.is_a? type
    end
  end
end
