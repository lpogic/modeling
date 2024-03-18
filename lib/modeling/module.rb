require_relative 'model_field'

module Modeling

  attr_accessor :model_fields

  def model *fields, **filtered_fields, &initializer
    self.model_fields = model_fields = fields.map{ ModelField.parse _1 } + 
      filtered_fields.map{ ModelField.parse _1, _2 }
    define_initialize self, &initializer
    model_fields.each do |f|
      attr_writer f.name if f.writer?
      attr_reader f.name if f.reader?
      attr_tester f.name if f.tester?
    end
  end

  def attr_tester symbol
    define_method "#{symbol}?" do
      !!instance_variable_get(symbol)
    end
  end
  
  private

  def self.model_arguments fields, *a, **na
    fields.zip(a).map do |f, arg| 
      value = na.key?(f.name) ? na[f.name] : arg
      if !f.filter.nil? && !(f.filter === value)
        if f.filter.respond_to? :from
          value = f.filter.from value
        else
          raise ArgumentError.new "#{value}(#{value.class}) does not match #{f.filter}"
        end
      end
      [f.name, value]
    end.to_h
  end

  def define_initialize initializer_class, &initializer
    define_method :initialize do |*a, **na, &b|
      model_fields = initializer_class.model_fields
      model_arguments = Modeling.model_arguments model_fields, *a, **na
      super(*(a[model_arguments.size..] || []), **na.except(*model_arguments.keys), &b)
      model_fields.each do |f|
        instance_variable_set f.attribute_name, model_arguments[f.name] if f.create_attr?
      end
      instance_exec **model_arguments, &initializer if initializer
    end
  end

end