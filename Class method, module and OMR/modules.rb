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
      @instances ||= ObjectSpace.each_object(self).count
    end

    def add_count
      @instances ||= ObjectSpace.each_object(self).count
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

