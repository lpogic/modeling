module Modeling
  class ModelField
    def initialize name, instance_variable, writer, reader, tester
      @name = name
      @instance_variable = instance_variable
      @writer = writer
      @reader = reader
      @tester = tester
    end

    attr :name

    def instance_variable_name
      "@#{name}"
    end

    def instance_variable?
      @instance_variable
    end

    def writer?
      @writer
    end

    def reader?
      @reader
    end

    def tester?
      @tester
    end

    class << self
      def parse argument, filter = nil
        case argument
        when ModelField
          argument
        when Symbol, String
          parse_model_field argument
        else
          raise "Unsupported argument #{argument} of #{argument.class} class."
        end
      end

      def parse_model_field argument
        instance_variable = reader = writer = tester = false
        if argument.start_with? "@"
          meta, name = argument.to_s.split "_", 2
          meta.to_s.each_char do |char|
            case char
            when "r", "R" then reader = true
            when "w", "W" then writer = true
            when "t", "T" then tester = true
            when "i", "I" then instance_variable = true
            end
          end
        else
          name = argument
          reader = writer = instance_variable = true
        end
        raise "Invalid model field #{argument}" unless name =~ /\w+/
        ModelField.new name.to_sym, instance_variable, writer, reader, tester
      end
    end
  end
end