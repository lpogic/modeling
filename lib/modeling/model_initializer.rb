module Modeling
  class ModelInitializer
    def initialize model_fields, super_caller, initialize_binding, rest, keyword, block
      @model_fields = model_fields
      @super_caller = super_caller
      @initialize_binding = initialize_binding
      @rest = rest
      @keyword = keyword
      @block = block
    end

    def super *a, **na, &b
      if a.size > 0 || na.size > 0 || b
        @super_caller.call a, na, b
      else
        @super_caller.call @rest, @keyword, @block
      end
    end

    def [](field)
      @initialize_binding.local_variable_get field
    end

    def respond_to? name
      super or @initialize_binding.local_variable_defined? name
    end

    def method_missing name
      @initialize_binding.local_variable_get name
    end

    def to_a
      @rest
    end

    def to_hash
      @keyword
    end

    def to_proc
      @block
    end

  end
end