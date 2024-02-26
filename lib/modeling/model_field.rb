module Modeling
  class ModelField
    def initialize name, assign, setter, getter
      @name = name
      @assign = assign
      @setter = setter
      @getter = getter
    end

    attr :name

    def attribute_name
      "@#{name}"
    end

    def assign?
      @assign
    end

    def setter?
      @setter
    end

    def getter?
      @getter
    end

    class << self
      def parse argument
        case argument
        when ModelField
          argument
        when String
          from_string argument
        when Symbol
          from_string argument.to_s
        when Array
          from_array argument
        else
          raise "Unsupported argument #{argument}"
        end
      end

      def from_string argument
        if argument =~ /(\W*)(\w+)(\W*)/
          modifiers = $1 + $3
          ModelField.new $2.to_sym, modifiers.include?("@") || modifiers.include?("?"), 
            modifiers.include?("@") || modifiers.include?("!") || modifiers.include?("="), 
            modifiers.include?("@") || modifiers.include?("!") || modifiers.include?(".")
        else 
          raise "Invalid argument string format '#{argument}'"
        end
      end

      def from_array argument
        name = argument.shift
        ModelField.new name, argument.include?(:assign), argument.include?(:setter), argument.include?(:getter)
      end

    end
  end
end