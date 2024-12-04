module Modeling
  class Exception < ::Exception
  end

  class ModelField
    def initialize name, initialize_argument, instance_variable, writer, reader, tester
      @name = name
      @initialize_argument = initialize_argument
      @instance_variable = instance_variable
      @writer = writer
      @reader = reader
      @tester = tester
    end

    attr :name

    def instance_variable_name
      "@#{name}"
    end

    def initialize_argument?
      @initialize_argument
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
          raise Exception.new "Unsupported argument #{argument} of #{argument.class} class."
        end
      end

      def parse_model_field argument
        initialize_argument = instance_variable = reader = writer = tester = false
        name_start = (0...argument.length).each do |i|
          case a = argument[i]
          when "R" then reader = true
          when "W" then writer = true
          when "T" then tester = true
          when "V" then instance_variable = true
          when "A" then initialize_argument = true
          when "@" then instance_variable = initialize_argument = true
          when "_" then break i + 1
          else
            if a.upcase != a
              break i
            else raise Exception.new "Invalid model field '#{argument}' - unknown option '#{a}'"
            end
          end
        end
        case name_start
        when 0
          initialize_argument = instance_variable = reader = writer = true
          name = argument
        when Integer
          name = argument[name_start..]
        else raise Exception.new "Invalid model field '#{argument}' - field name is missing"
        end

        raise Exception.new "Invalid model field #{argument} - field name '#{name}' is invalid" unless name =~ /\w+/
        ModelField.new name.to_sym, initialize_argument, instance_variable, writer, reader, tester
      end
    end
  end
end