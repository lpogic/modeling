module Modeling
  class ModelField
    def initialize name, instance_variable, writer, reader, super_argument
      @name = name
      @instance_variable = instance_variable
      @writer = writer
      @reader = reader
      @super_argument = super_argument
    end

    attr :name

    def instance_variable?
      @instance_variable
    end

    def super_argument?
      @super_argument
    end

    def writer?
      @writer
    end

    def reader?
      @reader
    end

    class << self
      def parse argument
        case argument
        when ModelField
          argument
        when Symbol, String
          form_symbol argument
        else
          raise Exception.new "Unsupported argument #{argument} of #{argument.class} class."
        end
      end

      def form_symbol symbol        
        if symbol.start_with? "@"
          instance_variable = true
          reader = writer = super_argument = false
          name = symbol[1..]
        elsif symbol.end_with? "="
          instance_variable = reader = writer = super_argument = false
          name = symbol[...-1]
        elsif symbol.end_with? "!"
          super_argument = true
          instance_variable = reader = writer = false
          name = symbol[...-1]
        else
          super_argument = false
          instance_variable = reader = writer = true
          name = symbol
        end
        
        raise Exception.new "Invalid model field '#{symbol}' - field name is empty" if name == ''
        raise Exception.new "Invalid model field #{symbol} - field name '#{name}' is invalid" unless name =~ /\w+/
        ModelField.new name.to_sym, instance_variable, writer, reader, super_argument
      end
    end
  end
end