module Modeling
  class ModelField
    def initialize name, instance_variable, writer, reader, nil_instance_variable
      @name = name
      @instance_variable = instance_variable
      @writer = writer
      @reader = reader
      @nil_instance_variable = nil_instance_variable
    end

    attr :name

    def instance_variable?
      @instance_variable
    end

    def nil_instance_variable?
      @nil_instance_variable
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
          parse_model_field argument
        else
          raise Exception.new "Unsupported argument #{argument} of #{argument.class} class."
        end
      end

      def parse_model_field argument
        instance_variable = reader = writer = nil_instance_variable = false
        name_start = (0...argument.length).each do |i|
          case a = argument[i]
          when "R" then reader = true
          when "W" then writer = true
          when "@" then instance_variable = true
          when "N" then nil_instance_variable = true
          when "_" then break i + 1
          else
            if a.upcase != a
              break i
            else raise Exception.new "Invalid model field '#{argument}' - unknown option '#{a}'"
            end
          end
        end
        name = case name_start
        when 0
          instance_variable = reader = writer = true
          argument
        when Integer
          argument[name_start..]
        else
          ''
        end

        raise Exception.new "Invalid model field '#{argument}' - field name is missing" if name == ''
        raise Exception.new "Invalid model field #{argument} - field name '#{name}' is invalid" unless name =~ /\w+/
        ModelField.new name.to_sym, instance_variable, writer, reader, nil_instance_variable
      end
    end
  end
end