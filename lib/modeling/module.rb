require_relative 'model_field'

module Modeling

  attr_accessor :model_fields

  def model *fields, &initializer
    self.model_fields = model_fields = fields.map{ ModelField.parse _1 }
    define_initialize self, &initializer
    model_fields.each do |field|
      attr_writer field.name if field.writer?
      attr_reader field.name if field.reader?
      attr_tester field.name if field.tester?
    end
  end
  
  private

  def attr_tester symbol
    define_method "#{symbol}?" do
      instance_variable_get(symbol) ? true : false
    end
  end

  def self.model_arguments fields, *a, **na
    fields.zip(a).map do |field, arg| 
      name = field.name
      value = na.key?(name) ? na[name] : arg 
      [name, value]
    end.to_h
  end

  def define_initialize initializer_class, &initializer
    define_method :initialize do |*a, **na, &b|
      model_fields = initializer_class.model_fields
      model_arguments = Modeling.model_arguments model_fields, *a, **na
      super_initialize = proc do |*asc, **nasc, &bsc|
        if asc.empty? && nasc.empty? && !bsc
          super(*(a[model_arguments.size..] || []), **na.except(*model_arguments.keys), &b)
        else
          super(*asc, **nasc, &bsc)
        end
      end
      model_fields.each do |field|
        instance_variable_set field.attribute_name, model_arguments[field.name] if field.create_attr?
      end
      if initializer
        instance_exec super_initialize, **model_arguments, &initializer
      else
        super_initialize.call
      end
    end
  end
end