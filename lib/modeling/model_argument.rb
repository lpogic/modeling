module Modeling
  class ModelArgument
    def initialize name, attribute, setter, getter, keyword, tester
      @name = name
      @attribute = attribute
      @setter = setter
      @getter = getter
      @keyword = keyword
      @tester = tester
    end

    attr :name

    def attribute_name
      "@#{name}"
    end

    def attribute?
      @attribute
    end

    def setter?
      @setter
    end

    def getter?
      @getter
    end

    def keyword?
      @keyword
    end

    def tester?
      @tester
    end

    class << self
      def parse argument
        case argument
        when ModelArgument
          argument
        when String
          from_string argument
        when Symbol
          from_symbol argument
        when Array
          from_array argument
        else
          raise "Unsupported argument #{argument}"
        end
      end

      def from_symbol argument
        name = argument.to_s.delete_prefix("@").to_sym
        attribute = argument.start_with?("@")
        ModelArgument.new name, attribute, attribute, attribute, false, false
      end

      def from_string argument
        if argument =~ /(\W*)(\w+)(\W*)/
          modifiers = $1 + $3
          ModelArgument.new $2.to_sym, modifiers.include?("@"), modifiers.include?("="), 
            modifiers.include?("+"), modifiers.include?(":"), modifiers.include?("?")
        else 
          raise "Invalid argument string format '#{argument}'"
        end
      end

      def from_array argument
        name = argument.shift
        ModelArgument.new name, argument.include?(:attribute), argument.include?(:setter), argument.include?(:getter), 
          argument.include?(:keyword), argument.include?(:tester)
      end

    end
  end
end