module Modeling
  class ModelField
    def initialize name, create_attr, writer, reader, tester
      @name = name
      @create_attr = create_attr
      @writer = writer
      @reader = reader
      @tester = tester
    end

    attr :name

    def attribute_name
      "@#{name}"
    end

    def create_attr?
      @create_attr
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
        reader = writer = tester = false
        attribute = true
        if argument.start_with? "@"
          meta, name = argument.to_s.split "_", 2
          meta.to_s.each_char do |char|
            case char
            when "r", "R" then reader = true
            when "w", "W" then writer = true
            when "t", "T" then tester = true
            when "i", "I" then attribute = false
            end
          end
        else
          name = argument
          reader = writer = true
        end
        raise "Invalid model field #{argument}" unless name =~ /\w+/
        ModelField.new name.to_sym, attribute, writer, reader, tester
      end
    end
  end
end