module Modeling
  class ModelField
    def initialize name, filter, create_attr, writer, reader, tester
      @name = name
      @filter = filter
      @create_attr = create_attr
      @writer = writer
      @reader = reader
      @tester = tester
    end

    attr :name
    attr :filter

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
        when Symbol
          from_symbol argument, filter
        when String
          from_string argument, filter
        when Array
          from_array argument, filter
        when Hash
          from_hash argument
        else
          raise "Unsupported argument #{argument}"
        end
      end

      def from_symbol argument, filter
        at = argument.start_with? "@"
        bang = argument.end_with? "!"
        hook = argument.end_with? "?"
        rail = argument.end_with? "="
        bald = !(at || bang || hook || rail)
        name = argument.to_s[/\w+/].to_sym
        ModelField.new name, filter, bald || hook || at || rail, bald || rail, bald || hook, false
      end

      def from_string argument, filter
        if argument =~ /(\w+)\s*(:?\/([traw\s]*))/
          ModelField.new $1.to_sym, filter, $2.include?("a"), $2.include?("w"), $2.include?("r"), $2.include?("t")
        else 
          raise "Invalid argument string format '#{argument}'"
        end
      end

      def from_array argument, filter
        name = argument.shift.to_sym
        ModelField.new name, filter, argument.include?(:attr), argument.include?(:writer), 
          argument.include?(:reader), argument.include?(:tester)
      end

      def from_hash argument
        name = argument[:name] || argument.keys.first
        filter = argument[:filter] || argument[name]
        parsed = parse name, filter
        ModelField.new parsed.name, parsed.filter, argument[:attr] || parsed.create_attr?,
          argument[:writer] || parsed.writer?, argument[:reader] || parsed.reader?,
          argument[:tester] || parsed.tester?
      end

    end
  end
end