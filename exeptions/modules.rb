module Validation
  def valid?
    validate!
  rescue RuntimeError
    false
  end
end

module ManufacturerName
  attr_accessor :manufacturer_name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def add_count
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :add_count
    end
  end
end

